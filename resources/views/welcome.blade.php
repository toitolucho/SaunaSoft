
<html >
    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
        <link rel="stylesheet" href="{{ asset('css/sb-admin-2.min.css') }}">
{{--        <link rel="stylesheet" href="{{ asset('css/dataTables.bootstrap4.min.css') }}">--}}

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-confirmation/1.0.5/bootstrap-confirmation.min.js"></script>
        <script src="{{ asset('js/sb-admin-2.min.js') }}"></script>
{{--        <script src="{{ asset('js/dataTables.bootstrap4.min.js') }}"></script>--}}
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/dt-1.10.20/datatables.min.css"/>

        <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/dt-1.10.20/datatables.min.js"></script>

        <title>Sauna SOFT</title>
    </head>
    <body id="page-top">
        <div id="wrapper">
            <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

                <!-- Sidebar - Brand -->
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                    <div class="sidebar-brand-icon rotate-n-15">
                        <i class="fas fa-laugh-wink"></i>
                    </div>
                    <div class="sidebar-brand-text mx-3">SaunaSoft <sup>1.0</sup></div>
                </a>

                <!-- Divider -->
                <hr class="sidebar-divider my-0">

                <!-- Nav Item - Dashboard -->
                <li class="nav-item active">
                    <a class="nav-link" href="index.html">
                        <i class="fas fa-fw fa-tachometer-alt"></i>
                        <span>Dashboard</span></a>
                </li>

                <!-- Divider -->
                <hr class="sidebar-divider">

                <!-- Heading -->
                <div class="sidebar-heading">
                    Interface
                </div>

                <!-- Nav Item - Pages Collapse Menu -->
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                        <i class="fas fa-fw fa-cog"></i>
                        <span>Administración</span>
                    </a>
                    <div id="collapseTwo" class="collapse show" aria-labelledby="headingTwo" data-parent="#accordionSidebar" style="">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <h6 class="collapse-header">Administración:</h6>
                            <a class="collapse-item" href="/categorias">Categorias</a>
                            <a class="collapse-item" href="/articulos">Articulos</a>
                            <a class="collapse-item" href="/comprasarticulos">Compras</a>
                            <a class="collapse-item" href="/clientes">Clientes</a>
                            <a class="collapse-item" href="/membresia">Membresia</a>
                            <a class="collapse-item" href="/ventasservicios">Ventas</a>
                        </div>
                    </div>
                </li>

                <!-- Nav Item - Utilities Collapse Menu -->
{{--                <li class="nav-item">--}}
{{--                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">--}}
{{--                        <i class="fas fa-fw fa-wrench"></i>--}}
{{--                        <span>Utilities</span>--}}
{{--                    </a>--}}
{{--                    <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">--}}
{{--                        <div class="bg-white py-2 collapse-inner rounded">--}}
{{--                            <h6 class="collapse-header">Custom Utilities:</h6>--}}
{{--                            <a class="collapse-item" href="utilities-color.html">Colors</a>--}}
{{--                            <a class="collapse-item" href="utilities-border.html">Borders</a>--}}
{{--                            <a class="collapse-item" href="utilities-animation.html">Animations</a>--}}
{{--                            <a class="collapse-item" href="utilities-other.html">Other</a>--}}
{{--                        </div>--}}
{{--                    </div>--}}
{{--                </li>--}}

                <!-- Divider -->
                <hr class="sidebar-divider">

                <!-- Heading -->
                <div class="sidebar-heading">
                    Addons
                </div>

                <!-- Nav Item - Pages Collapse Menu -->
{{--                <li class="nav-item">--}}
{{--                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">--}}
{{--                        <i class="fas fa-fw fa-folder"></i>--}}
{{--                        <span>Pages</span>--}}
{{--                    </a>--}}
{{--                    <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">--}}
{{--                        <div class="bg-white py-2 collapse-inner rounded">--}}
{{--                            <h6 class="collapse-header">Login Screens:</h6>--}}
{{--                            <a class="collapse-item" href="login.html">Login</a>--}}
{{--                            <a class="collapse-item" href="register.html">Register</a>--}}
{{--                            <a class="collapse-item" href="forgot-password.html">Forgot Password</a>--}}
{{--                            <div class="collapse-divider"></div>--}}
{{--                            <h6 class="collapse-header">Other Pages:</h6>--}}
{{--                            <a class="collapse-item" href="404.html">404 Page</a>--}}
{{--                            <a class="collapse-item" href="blank.html">Blank Page</a>--}}
{{--                        </div>--}}
{{--                    </div>--}}
{{--                </li>--}}

{{--                <!-- Nav Item - Charts -->--}}
{{--                <li class="nav-item">--}}
{{--                    <a class="nav-link" href="charts.html">--}}
{{--                        <i class="fas fa-fw fa-chart-area"></i>--}}
{{--                        <span>Charts</span></a>--}}
{{--                </li>--}}

{{--                <!-- Nav Item - Tables -->--}}
{{--                <li class="nav-item">--}}
{{--                    <a class="nav-link" href="tables.html">--}}
{{--                        <i class="fas fa-fw fa-table"></i>--}}
{{--                        <span>Tables</span></a>--}}
{{--                </li>--}}

{{--                <!-- Divider -->--}}
{{--                <hr class="sidebar-divider d-none d-md-block">--}}

{{--                <!-- Sidebar Toggler (Sidebar) -->--}}
{{--                <div class="text-center d-none d-md-inline">--}}
{{--                    <button class="rounded-circle border-0" id="sidebarToggle"></button>--}}
{{--                </div>--}}

            </ul>

            <div id="content-wrapper" class="d-flex flex-column">


                <div class="container container-fluid mt-4">
                    @yield('content')
                </div>

                <footer class="sticky-footer bg-white">
                    <div class="container my-auto">
                        <div class="copyright text-center my-auto">
                            <span>samin@solutions © SaunaSoft 2020</span>
                        </div>
                    </div>
                </footer>

            </div>
        </div>
    </body>
</html>