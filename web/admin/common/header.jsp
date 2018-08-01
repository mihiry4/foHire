<%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 29-07-2018
  Time: 03:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js" lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | Admire</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="img/logo1.ico"/>
    <!--global styles-->
    <link type="text/css" rel="stylesheet" href="css/components.css"/>
    <link type="text/css" rel="stylesheet" href="css/custom.css"/>
    <!-- end of global styles-->
    <link type="text/css" rel="stylesheet" href="vendors/c3/css/c3.min.css"/>
    <link type="text/css" rel="stylesheet" href="vendors/toastr/css/toastr.min.css"/>
    <link type="text/css" rel="stylesheet" href="vendors/switchery/css/switchery.min.css"/>
    <link type="text/css" rel="stylesheet" href="css/pages/new_dashboard.css"/>
    <link type="text/css" rel="stylesheet" href="#" id="skin_change"/>

</head>

<body class="body">
<div class="preloader" style=" position: fixed;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  z-index: 100000;
  backface-visibility: hidden;
  background: #ffffff;">
    <div class="preloader_img" style="width: 200px;
  height: 200px;
  position: absolute;
  left: 48%;
  top: 48%;
  background-position: center;
z-index: 999999">
        <img src="img/loader.gif" style=" width: 40px;" alt="loading...">
    </div>
</div>
<div class="bg-dark" id="wrap">
    <div id="top">
        <!-- .navbar -->
        <nav class="navbar navbar-static-top">
            <div class="container-fluid">
                <a class="navbar-brand text-xs-center" href="index.html">
                    <h4 class="text-white"><img src="img/logow.png" class="admin_img" alt="logo"> foHire Admimn</h4>
                </a>
                <div class="menu">
                        <span class="toggle-left" id="menu-toggle">
                        <i class="fa fa-bars text-white"></i>
                        </span>
                </div>

                <!-- Toggle Button -->
                <div class="text-xs-right xs_menu">
                    <button class="navbar-toggler hidden-xs-up" type="button" data-toggle="collapse"
                            data-target="#nav-content">
                        ☰
                    </button>
                </div>
                <!-- Nav Content -->
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="topnav dropdown-menu-right float-xs-right">



                    <div class="btn-group">
                        <div class="user-settings no-bg">
                            <button type="button" class="btn btn-default no-bg micheal_btn" data-toggle="dropdown">
                                <img src="img/admin.jpg" class="admin_img2 rounded-circle avatar-img" alt="avatar">
                                <strong>Micheal</strong>
                                <span class="fa fa-sort-down white_bg"></span>
                            </button>
                            <div class="dropdown-menu admire_admin">
                                <a class="dropdown-item title" href="#">
                                    Admire Admin</a>
                                <a class="dropdown-item" href="#"><i class="fa fa-cogs"></i>
                                    Account Settings</a>
                                <a class="dropdown-item" href="#">
                                    <i class="fa fa-user"></i>
                                    User Status
                                </a>
                                <a class="dropdown-item" href="#"><i class="fa fa-envelope"></i>
                                    Inbox</a>

                                <a class="dropdown-item" href="#"><i class="fa fa-lock"></i>
                                    Lock Screen</a>
                                <a class="dropdown-item" href="#"><i class="fa fa-sign-out"></i>
                                    Log Out</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
        <!-- /.container-fluid -->

