<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>GlobeGlimpse</title>
    <link href="globe/style.css" rel="stylesheet" />
    <script src="https://cdn.amcharts.com/lib/5/index.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/map.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/geodata/worldLow.js"></script>
    <script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" />
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="slick/slick-theme.css" />
    <link rel="stylesheet" href="css/templatemo-style.css" />
    <style>
        #btnsubmit{
            background: #AB7836;
            border: none;
            color:white;
            border-radius: 0;
            outline: none;
        }
        #btnsubmit:hover{
            background-color:#323B60;
        } 
    </style>
    <script src="//cdn.amcharts.com/lib/5/themes/Animated.js"></script>
    <script src="//cdn.amcharts.com/lib/5/themes/Micro.js"></script>
    <script src="//cdn.amcharts.com/lib/5/themes/Kelly.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#nl1").on("click", function () {
                $("#nl1").addClass("active");
                $("#nl2").removeClass("active");
                $("#nl3").removeClass("active");
                $("#nl4").removeClass("active");
            });
            $("#nl2").on("click", function () {
                $("#nl2").addClass("active");
                $("#nl1").removeClass("active");
                $("#nl3").removeClass("active");
                $("#nl4").removeClass("active");
            });
            $("#nl3").on("click", function () {
                $("#nl3").addClass("active");
                $("#nl2").removeClass("active");
                $("#nl1").removeClass("active");
                $("#nl4").removeClass("active");
            });
            $("#nl4").on("click", function () {
                $("#nl4").addClass("active");
                $("#nl2").removeClass("active");
                $("#nl3").removeClass("active");
                $("#nl1").removeClass("active");
            });
            $("#btnsubmit").on("click", function () {
                let uname = $("#contact_name").val();
                let mail = $("#contact_email").val();
                let num = $("#contact_number").val();
                let msg = $("#contact_message").val();
                if ((!isNaN(num) && num.length >= 10)) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Default.aspx/SendInfo",
                        data: "{'uName':'" + uname + "','mail':'" + mail + "','num':'" + num + "','msg':'" + msg + "'}",
                        dataType: "json",
                        success: function () {
                            alert("Your Response has been sent ;)");
                        },
                        error: function (request, err) {
                            alert("There was an error sending your response :(");
                        }
                    });
                    $("#u_name").val("");
                    $("#u_mail").val("");
                    $("#u_num").val("");
                    $("#u_msg").val("");
                }
                else {
                    alert("Value of Number should be Numeric");
                    $("#u_num").val("");
                    $("#u_num").focus();
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="tm-main-content" id="top">
                <div class="tm-top-bar-bg"></div>
                <div class="tm-top-bar" id="tm-top-bar">
                    <div class="container">
                        <div class="row">
                            <nav class="navbar navbar-expand-lg narbar-light">
                                <a class="navbar-brand mr-auto" style="font-family: 'TT Norms',sans-serif; font-size: large" href="Default.aspx">
                                    <img src="img/logo/navlogo.png" alt="Site logo"/>
                                    <strong style="color: #CEAF72;">Globe</strong>&nbsp;&nbsp;<strong style="color: #323B60;">Glimpse</strong>
                                </a>
                                <button type="button" id="nav-toggle" class="navbar-toggler collapsed" data-toggle="collapse" data-target="#mainNav" aria-expanded="false" aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>
                                <div id="mainNav" class="collapse navbar-collapse tm-bg-white">
                                    <ul class="navbar-nav ml-auto">
                                        <li class="nav-item">
                                            <a id="nl1" class="nav-link active" href="#top">Home <span class="sr-only">(current)</span></a>
                                        </li>
                                        <li class="nav-item">
                                            <a id="nl2" class="nav-link" href="#tm-section-2">Top Destinations</a>
                                        </li>
                                        <li class="nav-item">
                                            <a id="nl3" class="nav-link" href="#tm-section-3">Recommended Places</a>
                                        </li>
                                        <li class="nav-item">
                                            <a id="nl4" class="nav-link" href="#tm-section-4">Contact Us</a>
                                        </li>
                                    </ul>
                                </div>
                            </nav>
                        </div>
                        <!-- row -->
                    </div>
                    <!-- container -->
                </div>
                <!-- .tm-top-bar -->

                <div class="tm-page-wrap mx-auto" style="max-width: 1400px!important;">
                    <section class="tm-banner">
                        <div class="tm-container-outer tm-banner-bg">
                            <div class="container">
                                <div class="row tm-banner-row tm-banner-row-header">
                                    <div id="chartdiv"></div>
                                    
                                    <div class="tm-banner-header">
                                        <h2 style="display:none;" id="ctry-id"></h2>
                                    </div>
                                </div>
                                <div class="form-row tm-search-form-row">
                                    <div style="display: none;" class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
                                        <label for="inputCheckIn">Check In Date</label>
                                        <input name="check-in" type="text" class="form-control" id="inputCheckIn" placeholder="Check In" />
                                    </div>
                                    <div style="display: none;" class="form-group tm-form-group tm-form-group-pad tm-form-group-3">
                                        <label for="inputCheckOut">Check Out Date</label>
                                        <input name="check-out" type="text" class="form-control" id="inputCheckOut" placeholder="Check Out" />
                                    </div>
                                    <div style="display: none;" class="form-group tm-form-group tm-form-group-pad tm-form-group-1">
                                        <label for="btnSubmit">&nbsp;</label>
                                        <button type="submit" class="btn btn-primary tm-btn tm-btn-search text-uppercase" id="btnSubmit">Check Availability</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- row -->
                        <div class="tm-banner-overlay" style="min-height: 842px!important;z-index:3!important;"></div>
                    </section>
                </div>
                <!-- .container -->
            </div>
            <!-- .tm-container-outer -->

            <div class="tm-page-wrap" style="z-index:4!important;position:sticky!important;">
                <section class="p-5 tm-container-outer">
                    <div class="container">
                        <div class="row">
                            <div class="col-xs-12 mx-auto tm-about-text-wrap text-center">
                                <h2 class="text-uppercase mb-4">Your <strong>Journey</strong> is our priority</h2>
                                <p class="mb-4">Providing you with best possible trips and joyful experiences under a reasonable price is our main priority. We look forward to provide you with new ways to look at the world and assist you finding the true vacation you and your loved ones deserve.</p>
                                <a href="#tm-section-3" class="text-uppercase btn-primary tm-btn">Explore Further</a>
                            </div>
                        </div>
                    </div>
                </section>

                <div class="tm-container-outer" id="tm-section-2">
                    <section class="tm-slideshow-section">
                        <div class="tm-slideshow">
                            <img src="img/tajmahel.jpg" alt="Image" />
                            <img src="img/varanasi.jpg" alt="Image" />
                            <img src="img/sou.jpeg" alt="Image" />
                        </div>
                        <div class="tm-slideshow-description tm-bg-primary">
                            <h2 class="">Majestic India</h2>
                            <p>One of the oldest civilisations in the world, India is a mosaic of multicultural experiences. With a rich heritage and myriad attractions, the country is among the most popular tourist destinations in the world. It covers an area of 32, 87,263 sq. km, extending from the snow-covered Himalayan heights to the tropical rain forests of the south.</p>
                            <a href="#" class="text-uppercase tm-btn tm-btn-white tm-btn-white-primary">Explore Further</a>
                        </div>
                    </section>
                    <section class="clearfix tm-slideshow-section tm-slideshow-section-reverse">

                        <div class="tm-right tm-slideshow tm-slideshow-highlight">
                            <img src="img/swiss1.jpg" alt="Image"/>
                            <img src="img/swiss2.jpg" alt="Image"/>
                            <img src="img/swiss3.png" alt="Image"/>
                        </div>

                        <div class="tm-slideshow-description tm-slideshow-description-left tm-bg-highlight">
                            <h2 class="">Stunning Switzerland</h2>
                            <p>Embark on a Swiss adventure with us! We're dedicated to curating unforgettable experiences at unbeatable prices. Discover new perspectives in the heart of Switzerland. Let us help you find the perfect vacation you and your loved ones deserve. Your journey to picturesque landscapes and cultural richness begins here!</p>
                            <a href="#" class="text-uppercase tm-btn tm-btn-white tm-btn-white-highlight">Explore Further</a>
                        </div>

                    </section>
                    <section class="tm-slideshow-section">
                        <div class="tm-slideshow">
                            <img src="img/egy1.jpeg" alt="Image">
                            <img src="img/egy2.jpg" alt="Image">
                            <img src="img/egy3.jpg" alt="Image">
                        </div>
                        <div class="tm-slideshow-description tm-bg-primary">
                            <h2 class="">Mystical Egypt</h2>
                            <p>Experience the magic of Egypt with our carefully curated tours. Immerse yourself in ancient history, explore awe-inspiring pyramids, and cruise along the Nile River. We prioritize delivering exceptional trips and unforgettable moments, all within your budget. Discover a new perspective on Egypt, tailored for you and your loved ones.</p>
                            <a href="#" class="text-uppercase tm-btn tm-btn-white tm-btn-white-primary">Explore Further</a>
                        </div>
                    </section>
                </div>
                <div class="tm-container-outer" id="tm-section-3">
                    <ul class="nav nav-pills tm-tabs-links">
                        <li class="tm-tab-link-li">
                            <a href="#1a" data-toggle="tab" class="tm-tab-link">
                                <img src="img/north-america.png" alt="Image" class="img-fluid">
                                North America
                            </a>
                        </li>
                        <li class="tm-tab-link-li">
                            <a href="#2a" data-toggle="tab" class="tm-tab-link">
                                <img src="img/south-america.png" alt="Image" class="img-fluid">
                                South America
                            </a>
                        </li>
                        <li class="tm-tab-link-li">
                            <a href="#3a" data-toggle="tab" class="tm-tab-link">
                                <img src="img/europe.png" alt="Image" class="img-fluid">
                                Europe
                            </a>
                        </li>
                        <li class="tm-tab-link-li">
                            <a href="#4a" data-toggle="tab" class="tm-tab-link active">
                                <!-- Current Active Tab -->
                                <img src="img/asia.png" alt="Image" class="img-fluid">
                                Asia
                            </a>
                        </li>
                        <li class="tm-tab-link-li">
                            <a href="#5a" data-toggle="tab" class="tm-tab-link">
                                <img src="img/africa.png" alt="Image" class="img-fluid">
                                Africa
                            </a>
                        </li>
                        <li class="tm-tab-link-li">
                            <a href="#6a" data-toggle="tab" class="tm-tab-link">
                                <img src="img/australia.png" alt="Image" class="img-fluid">
                                Australia
                            </a>
                        </li>
                        <li class="tm-tab-link-li">
                            <a href="#7a" data-toggle="tab" class="tm-tab-link">
                                <img src="img/antartica.png" alt="Image" class="img-fluid">
                                Antartica
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content clearfix">

                        <!-- Tab 1 -->
                        <div class="tab-pane fade" id="1a">
                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/nyc.png" alt="Imagetm-page-wrap" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">NYC, New York</h3>
                                        <p class="tm-text-highlight">United States</p>
                                        <p class="tm-text-gray">Known as "The Big Apple," it's a global hub for culture, fashion, art, and finance. Don't miss the Statue of Liberty, Times Square, Central Park, and Broadway.</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$110</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/benff.png" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Benff National Park, Alberta</h3>
                                        <p class="tm-text-highlight">Canada</p>
                                        <p class="tm-text-gray">Located in the Canadian Rockies, Banff National Park is known for its stunning mountain landscapes, crystal-clear lakes, and abundant wildlife. Visitors can explore hiking trails, go wildlife spotting, and enjoy activities like canoeing, skiing, and taking a scenic drive along the Icefields Parkway.</p>
                                    </div>
                                    <div id="preload-hover-img"></div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$120</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/cancun.png" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Cancún, Quintana Roo</h3>
                                        <p class="tm-text-highlight">Mexico</p>
                                        <p class="tm-text-gray">ituated on the Yucatán Peninsula along the Caribbean Sea, Cancún is renowned for its stunning beaches, turquoise waters, and vibrant nightlife. It's a top destination for sun-seekers and water sports enthusiasts.</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$130</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/manuel.png" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Manuel Antonio National Park</h3>
                                        <p class="tm-text-highlight">Costa Rica</p>
                                        <p class="tm-text-gray">Located on the Pacific coast, Manuel Antonio is renowned for its incredible biodiversity and stunning natural beauty. The park is home to lush rainforests, pristine beaches, and abundant wildlife.</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$140</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!-- tab-pane -->

                        <!-- Tab 2 -->
                        <div class="tab-pane fade" id="2a">

                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-05.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">South Resort Hotel</h3>
                                        <p class="tm-text-highlight">South One</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$220</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-04.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Aenean ac ante nec diam</h3>
                                        <p class="tm-text-highlight">South Second</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$230</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-07.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Suspendisse nec dapibus</h3>
                                        <p class="tm-text-highlight">South Third</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$240</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-06.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Aliquam viverra mi at nisl</h3>
                                        <p class="tm-text-highlight">South Fourth</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$250</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!-- tab-pane -->

                        <!-- Tab 3 -->
                        <div class="tab-pane fade" id="3a">

                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-04.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Europe Hotel</h3>
                                        <p class="tm-text-highlight">Venecia, Italy</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$330</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-05.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">In viverra enim turpis</h3>
                                        <p class="tm-text-highlight">Paris, France</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$340</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-06.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Volutpat pellentesque</h3>
                                        <p class="tm-text-highlight">Barcelona, Spain</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$350</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-07.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Grand Resort Pasha</h3>
                                        <p class="tm-text-highlight">Istanbul, Turkey</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$360</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!-- tab-pane -->

                        <!-- Tab 4 -->
                        <div class="tab-pane fade show active" id="4a">
                            <!-- Current Active Tab WITH "show active" classes in DIV tag -->
                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-06.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Asia Resort Hotel</h3>
                                        <p class="tm-text-highlight">Singapore</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$440</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-07.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Nullam eget est a nisl</h3>
                                        <p class="tm-text-highlight">Yangon, Myanmar</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <div id="preload-hover-img"></div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$450</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-05.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Proin interdum ullamcorper</h3>
                                        <p class="tm-text-highlight">Bangkok, Thailand</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$460</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-04.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Lorem ipsum dolor sit</h3>
                                        <p class="tm-text-highlight">Vientiane, Laos</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$470</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!-- tab-pane -->

                        <!-- Tab 5 -->
                        <div class="tab-pane fade" id="5a">

                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-05.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Africa Resort Hotel</h3>
                                        <p class="tm-text-highlight">First City</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$550</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-04.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Aenean ac magna diam</h3>
                                        <p class="tm-text-highlight">Second City</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$560</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-07.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Beach Barbecue Sunset</h3>
                                        <p class="tm-text-highlight">Third City</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$570</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-06.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Grand Resort Pasha</h3>
                                        <p class="tm-text-highlight">Fourth City</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$580</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!-- tab-pane -->

                        <!-- Tab 6 -->
                        <div class="tab-pane fade" id="6a">

                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-04.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Hotel Australia</h3>
                                        <p class="tm-text-highlight">City One</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$660</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-05.jpg" alt="Image" class="img-fluid tm-recommended-img">
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Proin interdum ullamcorper</h3>
                                        <p class="tm-text-highlight">City Two</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$650</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-06.jpg" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Beach Barbecue Sunset</h3>
                                        <p class="tm-text-highlight">City Three</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$640</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-07.jpg" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Grand Resort Pasha</h3>
                                        <p class="tm-text-highlight">City Four</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$630</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!-- tab-pane -->

                        <!-- Tab 7 -->
                        <div class="tab-pane fade" id="7a">

                            <div class="tm-recommended-place-wrap">
                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-04.jpg" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Antartica Resort</h3>
                                        <p class="tm-text-highlight">Ant City One</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$770</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-05.jpg" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Pulvinar Semper</h3>
                                        <p class="tm-text-highlight">Ant City Two</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$230</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-06.jpg" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Cras vel sapien</h3>
                                        <p class="tm-text-highlight">Ant City Three</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$140</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>

                                <div class="tm-recommended-place">
                                    <img src="img/tm-img-07.jpg" alt="Image" class="img-fluid tm-recommended-img" />
                                    <div class="tm-recommended-description-box">
                                        <h3 class="tm-recommended-title">Nullam eget est</h3>
                                        <p class="tm-text-highlight">Ant City Four</p>
                                        <p class="tm-text-gray">Sed egestas, odio nec bibendum mattis, quam odio hendrerit risus, eu varius eros lacus sit amet lectus. Donec blandit luctus dictum...</p>
                                    </div>
                                    <a href="#" class="tm-recommended-price-box">
                                        <p class="tm-recommended-price">$190</p>
                                        <p class="tm-recommended-price-link">Continue Reading</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!-- tab-pane -->
                    </div>
                </div>

                <div class="tm-container-outer tm-position-relative" id="tm-section-4">
                    <div id="google-map" style="z-index:1;background-image:url(../img/logo/bgcontact.png);background-repeat:no-repeat;background-size:cover;"></div>
                    <div class="tm-banner-overlay1" style="z-index:2;min-height: auto!important;"></div>
                    <div class="tm-contact-form" style="z-index:3;">
                        <div class="form-group tm-name-container">
                            <input type="text" id="contact_name" name="contact_name" class="form-control" placeholder="Name" required="required" />
                        </div>
                        <div class="form-group tm-email-container">
                            <input type="email" id="contact_email" name="contact_email" class="form-control" placeholder="Email" required="required" />
                        </div>
                        <div class="form-group">
                            <input type="text" id="contact_number" name="contact_number" class="form-control" placeholder="Contact Number" required="required" />
                        </div>
                        <div class="form-group">
                            <textarea id="contact_message" name="contact_message" class="form-control" rows="9" placeholder="Message" required="required"></textarea>
                        </div>
                        <button id="btnsubmit" type="button" class="btn tm-btn-primary tm-btn-send text-uppercase">Send Message Now</button>
                    </div>
                </div>
            </div>
            <!-- .tm-container-outer -->

            <footer class="tm-container-outer" style="background-color:#AB7836;">
                <p class="mb-0">
                    Copyright © <span class="tm-current-year">2018</span> GlobeGlimpse
                        
                    . Designed by <a rel="nofollow" href="http://www.google.com/+templatemo" target="_parent">PSK</a>
                </p>
            </footer>
        </div>
    </form>
    <footer style="display: none;">
        <script src="js/jquery-1.11.3.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/datepicker.min.js"></script>
        <script src="js/jquery.singlePageNav.min.js"></script>
        <script src="slick/slick.min.js"></script>
        <script src="js/jquery.scrollTo.min.js"></script>
        <script src="globe/script.js"></script>
        <script> 

            /* DOM is ready
            ------------------------------------------------*/
            $(function () {

                // Change top navbar on scroll
                $(window).on("scroll", function () {
                    if ($(window).scrollTop() > 100) {
                        $(".tm-top-bar").addClass("active");
                    } else {
                        $(".tm-top-bar").removeClass("active");
                    }
                });

                // Smooth scroll to search form
                $('.tm-down-arrow-link').on("click", function () {
                    $.scrollTo('#tm-section-search', 300, { easing: 'linear' });
                });

                // Date Picker in Search form
                var pickerCheckIn = datepicker('#inputCheckIn');
                var pickerCheckOut = datepicker('#inputCheckOut');

                // Update nav links on scroll
                $('#tm-top-bar').singlePageNav({
                    currentClass: 'active',
                    offset: 60
                });

                // Close navbar after clicked
                $('.nav-link').on("click", function () {
                    $('#mainNav').removeClass('show');
                });

                // Slick Carousel
                $('.tm-slideshow').slick({
                    infinite: true,
                    arrows: true,
                    slidesToShow: 1,
                    slidesToScroll: 1
                });

                loadGoogleMap();                                       // Google Map                
                $('.tm-current-year').text(new Date().getFullYear());  // Update year in copyright           
            });

        </script>
    </footer>
</body>
</html>
