<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="GGlimpse.Chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chat-Room</title>
    <link href="css/ChatStyle.css" rel="stylesheet" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="Scripts/jquery-3.7.1.min.js"></script>
    <script src="Scripts/jquery.signalR-2.4.3.js"></script>
    <script src="signalr/hubs"></script>
    <script>
        $(function () {
            // Get room key
            const url = new URL(window.location.href)
            const RoomID = url.searchParams.get("Room");

            // Used to store Date of previous message so that we can make breakpoints
            // between different days
            let prevMessageDate = null;

            // Conenct to SignalR Hub
            var chatHub = $.connection.chatHub;

            function AddMessage(user, message, timeStamp) {
                let msgDteTime = new Date(Date.parse(timeStamp));

                if (prevMessageDate == null || prevMessageDate !== msgDteTime.getDate()) {
                    // It is the first Message of that day or first message of the chat.
                    // Enter a date breakpoint
                    const msgDteStr = msgDteTime.getDate() + "/" + msgDteTime.getMonth() + "/" + msgDteTime.getFullYear();
                    $("#Chat").append('<center><h3>' + msgDteStr + '</h3></center>');
                }

                prevMessageDate = msgDteTime.getDate();
                // Update the chat messages UI.
                const timestampStr = msgDteTime.toLocaleString("en-US", { hour: "numeric", minute: "numeric", hour12: true, })

                //Check if user is system
                if (user === "system") {
                    $('#Chat').append("<center><h5>" + message + "</h5></center>");
                }
                else if (user === $("[id$=UserNameLbl]").text()) {
                    // Format the message
                    var DisplayMsg = `
                     <div class="outgoing_msg">
                         <div class="sent_msg">
                             <p>${message}</p>
                             <span class="time_date">${timestampStr}</span>
                         </div>
                     </div>`;

                    $('#Chat').append(DisplayMsg);
                }
                else {
                    var DisplayMsg = `
                     <div class="incoming_msg">
                         <div class="received_msg">
                             <div class="received_withd_msg">
                                 <div class="sender_name">
                                     ${user}
                                 </div>
                                 <p>${message}</p>
                                 <span class="time_date">${timestampStr}</span>
                             </div>
                         </div>
                     </div>`;
                    $('#Chat').append(DisplayMsg);
                }
            }

            // Function to recieve message from other users or system
            chatHub.client.recieveMessage = AddMessage;

            chatHub.client.addUserToMembers = (UName, UID) => {
                var dropdown = $("#MembersDropDown");

                // If dropdown exists, i.e. user is an admin
                if (dropdown.length !== 0) {
                    dropdown.append("<option value='" + UID + "'>" + UName + "</option>");
                }
            }

            chatHub.client.bannedFromGroup = (RoomName) => {
                console.log("You have been kicked from " + RoomName);
            }

            function isNewUser(userID) {
                chatHub.server.newUserJoined(RoomID, user, userID);
            }

            // Join the room using room key in url
            $.connection.hub.start().done(function () {

                var user = $("#UserNameLbl").text();
                var userID = $("#UserObjID").val();
                chatHub.server.joinRoom(RoomID, userID);


                // Get messages from .json file and unload them to chat
                $.ajax({
                    type: "POST",
                    url: "Chatroom.aspx/GetChatMessages",
                    data: '{ RoomID: "' + RoomID + '" }',
                    contentType: "application/json; charset=utf-8",
                    success: function (response) {
                        const messages = JSON.parse(response.d);
                        messages.forEach((msg) => {
                            AddMessage(msg.UserName, msg.Message, msg.TimeStamp);
                        });
                    }
                });

                $('#sendButton').click(function () {
                    var message = $('#messageInput').val();
                    $('#messageInput').val('');
                    console.log("Sending message");
                    chatHub.server.sendMessage(RoomID, user, message, userID);
                    $("#messageInput").focus();
                    return false;
                });
            });

            // Admin control methods

            // Remove a member from the group
            $("#BanUserBtn").click(() => {
                const selectedOption = $("#MembersDropDown option:selected");
                const selectionText = selectedOption.text();
                const selectionVal = $("#MembersDropDown").val();
                // If valid user is selected
                if (selectionVal !== "invalid") {
                    const remUser = confirm("Ban " + selectionText + " from the group?");
                    if (remUser) {
                        var data = {
                            UserID: selectionVal,
                            UserName: selectionText,
                            RoomID: RoomID
                        };
                        $.ajax({
                            type: "POST",
                            url: "Chatroom.aspx/RemoveUser",
                            data: JSON.stringify(data),
                            contentType: "application/json; charset=utf-8",
                            success: function (response) {
                                selectedOption.remove();
                                // If no more users remain
                                if ($("#MembersDropDown option").length === 0) {
                                    $("#MembersDropDown").append("<option value='invalid'>No members</option>");
                                }
                                const message = response.d;
                                // Make a system generated message displaying that user was removed
                                chatHub.server.sendMessage(RoomID, "system", message);
                                // Link of group, Name of group, ID of user
                                var chatName = '<%= ChatName.Text %>';
                                chatHub.server.banUser(RoomID, chatName, selectionVal);
                                alert(message);
                            }
                        });
                    } else {
                        alert("Cancelled removal of user");
                    }
                }
                return false;
            });

            $("#DeleteGroupBtn").click(() => {
                const deleteGroup = confirm('Delete group<%= ChatName.Text %>?');
                if (deleteGroup) {
                    var data = {
                        RoomID: RoomID
                    };
                    $.ajax({
                        type: "POST",
                        url: "Chatroom.aspx/DeleteGroup",
                        data: JSON.stringify(data),
                        contentType: "application/json; charset=utf-8",
                        success: function (response) {
                            const message = response.d;
                            alert(message);
                            window.location.assign(window.location.origin + "/default.aspx");
                        }
                    });
                } else {
                    alert("Deletion of group was cancelled");
                }
                return false;
            });

            $("#CopyGroupLink").click((e) => {
                e.preventDefault();
                var Link = window.location;
                var tempTextarea = $('<textarea>');
                $('body').append(tempTextarea);
                tempTextarea.val(Link).select();
                document.execCommand('copy');
                tempTextarea.remove();
                alert("Copied Group link");
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="messaging">
                <div class="inbox_msg">
                    <div class="inbox_people">
                        <div class="headind_srch">
                            <div class="recent_heading">
                                <h4>
                                    <asp:Label Text="" ID="UserNameLbl" runat="server" />
                                    <asp:HiddenField ID="UserObjID" ClientIDMode="Static" runat="server" />
                                </h4>
                            </div>
                        </div>
                        <div class="inbox_chat">
                            <asp:Repeater ID="ChatsNav" runat="server" ItemType="GGlimpse.DataModels.ChatLink">
                                <ItemTemplate>
                                    <div class="chat_list active_chat">
                                        <div class="chat_people">
                                            <div class="chat_ib">
                                                <a class="GroupLink" href='<%# "./Chat.aspx?Room=" + Item.GroupLink %>'><%# Item.GroupName %> </a>
                                                <p>Members: <%# String.Join(", ",Item.Users) %></p>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <div class="Flex-End">
                                <asp:TextBox runat="server" ID="GroupNameTBox" placeholder="Name of Group" />
                                <asp:Button Text="Create New" ID="newGroup" runat="server" OnClick="newGroup_Click" />
                            </div>
                        </div>
                    </div>
                    <div class="mesgs">
                        <div class="ChatInfoBar">
                            <asp:Label Text="" ID="ChatName" CssClass="recent_heading" runat="server" />
                            <button id="CopyGroupLink" class="btn btn-info">
                                <i class="fa fa-link" aria-hidden="true"></i>
                                Copy Link
                            </button>
                            <div id="AdminControlBox" class="AdminControlsBox" runat="server">
                                <asp:DropDownList runat="server" CssClass="form-select" ID="MembersDropDown" ClientIDMode="Static">                                    
                                </asp:DropDownList>
                                <button id="BanUserBtn" class="btn btn-danger">
                                    <i class="fa fa-ban" aria-hidden="true"></i>
                                    Ban User
                                </button>
                                <button id="DeleteGroupBtn" class="btn btn-danger">
                                    <i class="fa fa-trash-o" aria-hidden="true"></i>
                                    Delete Group
                                </button>
                            </div>
                        </div>
                        <div class="msg_history" id="Chat">
                        </div>
                        <div class="type_msg">
                            <div class="input_msg_write">
                                <input type="text" id="messageInput" class="write_msg" placeholder="Type a message" />
                                <button class="msg_send_btn" id="sendButton" type="button"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
