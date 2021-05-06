
<html >
    <head name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <script src="{{ asset('js/jquery-3.6.0.min.js') }}"></script>
		<script src="{{ asset('js/jquery-ui.min.js') }}"></script>
		<script src="{{ asset('js/popper.min.js') }}"></script>
		<script src="{{ asset('js/bootstrap.min.js') }}"></script>
		<script src="{{ asset('js/bootstrap-confirmation.min.js') }}"></script>
		<script src="{{ asset('js/bootstrap.bundle.min.js') }}"></script>
		<script src="{{ asset('js/sb-admin-2.min.js') }}"></script>
		<script src="{{ asset('js/typeahead.bundle.js') }}"></script>
		<script src="{{ asset('js/bootbox.min.js') }}"></script>
		
		
		
		<link rel="stylesheet" href="{{ asset('css/sb-admin-2.min.css') }}">
		<link rel="stylesheet" href="{{ asset('css/all.css') }}">
		<link rel="stylesheet" href="{{ asset('css/bootstrap.min.css') }}">



        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script type="text/javascript">
            $(function () {
                $('.alert-success').fadeIn().delay(1500).fadeOut(1000);

                $('.reporteFecha').click(function(){

                    console.log(new Date());

                    $(".reporteFecha").attr("href", $(".reporteFecha").attr("href") + "/"+ new Date().getTime()/ 1000 );

                });

            });
        </script>
        <title>Sauna SOFT</title>
    </head>
    <body id="page-top">
        <div id="wrapper">
            <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

                <!-- Sidebar - Brand -->
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
                    <div class="sidebar-brand-icon rotate-n-15">
                        <i class="fas fa-hot-tub"></i>
                    </div>
                    <div class="sidebar-brand-text mx-3">SaunaSoft <sup>1.0</sup></div>
                </a>

                <!-- Divider -->
                <hr class="sidebar-divider my-0">

{{--                <!-- Nav Item - Dashboard -->--}}
{{--                <li class="nav-item active">--}}
{{--                    <a class="nav-link" href="index.html">--}}
{{--                        <i class="fas fa-fw fa-tachometer-alt"></i>--}}
{{--                        <span>Dashboard</span></a>--}}
{{--                </li>--}}

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
                            <a class="collapse-item" href="{{route("categorias.index")}}"> <i class="fas fa-fw fa-cogs"> </i>  Categorias</a>

                            <a class="collapse-item" href="{{route("tiposclientes.index")}}"> <i class="fas fa-fw fa-users-cog"> </i>  Tipos Clientes</a>
                            <a class="collapse-item" href="{{route("proveedores.index")}}"> <i class="fas fa-fw fa-dolly"> </i>  Proveedores</a>
                            <a class="collapse-item" href="{{route("articulos.index")}}"><i class="fas fa-fw fa-box-open"> </i>  Articulos</a>
                            <a class="collapse-item" href="{{route("comprasarticulos.index")}}"> <i class="fas fa-fw fa-truck-moving">  </i>  Compras</a>
                            <a class="collapse-item" href="{{route("clientes.index")}}"><i class="fas fa-fw fa-user-friends"> </i>  Clientes</a>
                            <a class="collapse-item" href="{{route("membresias.index")}}"><i class="fas fa-fw fa-address-card"> </i>  Membresia</a>
                            <a class="collapse-item" href="{{route("ventasservicios.index")}}"><i class="fas fa-fw fa-shopping-cart"> </i> Ventas</a>
                            <a class="collapse-item" href="{{route("promociones.index")}}"><i class="fas fa-fw fa-bullhorn"> </i> Promociones</a>
                            <a class="collapse-item" href="{{route("servicios.index")}}"> <i class="fas fa-fw fa-shower"> </i>  Servicios</a>
                        </div>
                    </div>
                </li>

                <!-- Nav Item - Utilities Collapse Menu -->
                <li class="nav-item">
                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
                        <i class="fas fa-fw fa-table"></i>
                        <span>Reportes</span>
                    </a>
                    <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <h6 class="collapse-header">Movimiento Diario:</h6>
                            <a class="collapse-item" href="{{@route("reportes.inventariodiario")}}">Movimiento a la Fecha</a>
                            <a class="collapse-item reporteFecha" href="{{@route("reportes.inventarioinicioenfecha", "")}}">Apertura</a>
                            <a class="collapse-item reporteFecha" href="{{@route("reportes.inventariocierreenfecha", "")}}">Cierre</a>

                        </div>
                    </div>
                </li>

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
