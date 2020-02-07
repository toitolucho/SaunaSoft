@extends('layouts.base')
@section('content')

	<style>
		.listado
		{
			list-style-type: none !important;
		}
	</style>

	<!-- Dialog show event handler -->
    <script type="text/javascript">

		$(function() {
			$(".formConfirm").click(function(e){
				e.preventDefault();
				var el = $(this).parent();
				var title = el.attr('data-title');
				var msg = el.attr('data-message');
				var dataForm = el.attr('data-form');


				$('#formConfirm')
				    .find('#frm_body').html(msg)
				    .end().find('#frm_title').html(title)
				    .end().modal('show');

				$('#formConfirm').find('#frm_submit').attr('data-form', dataForm);

			});
		});
		$(function() {
			$("#frm_submit").click(function(e){
				//console.log("registro a eliminar")
				var id = $(this).attr('data-form');
				console.log("entra confirm" + id );
				$(id).submit();
			});

		});

    </script>

    <!-- Modal Dialog -->
    <div class="modal fade" id="formConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
					<h4 class="modal-title" id="frm_title">Eliminar registro</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
						<span class="sr-only">Cerrar</span>
					</button>

                </div>


                <div class="modal-body" id="frm_body"></div>
                <div class="modal-footer">
                    <button style='margin-left:10px;' type="button" class="btn btn-primary col-sm-2 pull-right" id="frm_submit">Aceptar</button>
                    <button type="button" class="btn btn-danger col-sm-2 pull-right" data-dismiss="modal" id="frm_cancel">Cancelar</button>
                </div>
            </div>
        </div>
    </div>


    <div class="card">
			<div class="card-header"><i class="fa fa-fw fa-globe"></i> <strong>Listado de Categorias</strong>






				<a href="/categorias/create" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-plus-circle"></i> Agregar Categoria</a></div>

				<div class="col-md-4 float-right">
					<form action="/categorias/buscar" method="POST" role="search">
                        {{ csrf_field() }}
						<div class="input-group ">
							<input type="search" name="NombreCategoria" class="form-control">
							<span class="input-group-prepend">
								<button type="submit" class="btn btn-primary">Buscar</button>
							</span>
						</div>
					</form>
				</div>


            </div>
			<div class="card-body">

				@if (session('eliminar'))
					<div class="alert alert-success"><i class="fa fa-thumbs-up"></i>
						{{ session('eliminar') }}
					</div>


				@endif

				@if (session('eliminar_error'))
					<div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i>
						{{ session('eliminar_error') }}
					</div>


				@endif
				@if (session('editado'))
					<div class="alert alert-success"><i class="fa fa-thumbs-up"></i>
						{{ session('editado') }}
					</div>


				@endif

				@if (session('editado_error'))
					<div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i>
						{{ session('editado_error') }}
					</div>


				@endif

                @if (session('no_encontrado'))
                    <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i>
                        {{ session('no_encontrado') }}
                    </div>


                @endif
			</div>
        <div>





			<table class="table table-striped table-bordered listado" >
				<thead>
					<tr class="bg-primary text-white">
                        <th>
							<span class="custom-checkbox">
								<input type="checkbox" id="selectAll">
								<label for="selectAll"></label>
							</span>
						</th>
						<th>Codigo</th>
						<th>Categoria</th>						
						<th class="text-center">Acciones</th>
					</tr>
				</thead>
				<tbody>
                    @foreach($categorias as $categoria)
						<tr>
                            <td>
							<span class="custom-checkbox">
								<input type="checkbox" id="checkbox1" name="options[]" value="1">
								<label for="checkbox1"></label>
							</span>
						    </td>
                            <td>{{$categoria->IdCategoria}}</td>
							<td>{{$categoria->NombreCategoria}}  </td>

                            <td>

                                <li data-form="#delete-form-{{$categoria->IdCategoria}}" data-title="Eliminar categoria" data-message="Se encuentra seguro de eliminar esta categoria ?"  data-target="#formConfirm">
									<a href="/categorias/{{$categoria->IdCategoria}}/edit" class="text-primary"><i class="fa fa-fw fa-edit"></i> Editar</a>
                                    <a data-toggle="modal" class="formConfirm text-danger" href="" data-target="#formConfirm">
										<i class="fa fa-fw fa-trash"></i>
										Eliminar
									</a>

                                </li>

                                <form id ="delete-form-{{$categoria->IdCategoria}}" action="/categorias/{{$categoria->IdCategoria}}" method="post" style="display: none">
                                    <input type="hidden" name="_method" value="delete">
                                    {{csrf_field()}}

                                </form>

                            </td>


{{--                            <td align="center">--}}
{{--							    <a href="/categorias/{{$categoria->IdCategoria}}/edit" class="text-primary"><i class="fa fa-fw fa-edit"></i> Editar</a> | --}}
{{--							    <a href="/categorias/{{$categoria->IdCategoria}}" class="text-danger" onClick="--}}
{{--										var result = confirm('Se encuentra seguro de eliminar el registro?');--}}
{{--										if(result){--}}
{{--											event.preventDefault();--}}
{{--											document.getElementById('delete-form{{$categoria->IdCategoria}}').submit();--}}

{{--										}--}}
{{--									">--}}
{{--									<i class="fa fa-fw fa-trash"></i>--}}
{{--									Eliminar--}}
{{--								</a>--}}
{{--								<form id ="delete-form{{$categoria->IdCategoria}}" action="/categorias/{{$categoria->IdCategoria}}" method="post" style="display: none">--}}
{{--									<input type="hidden" name="_method" value="delete">--}}
{{--									{{csrf_field()}}--}}

{{--								</form>--}}
{{--						    </td>--}}
						</tr>
				    @endforeach


				</tbody>

			</table>
			{{ $categorias->links() }}
		</div> <!--/.col-sm-12-->
            

@endsection



