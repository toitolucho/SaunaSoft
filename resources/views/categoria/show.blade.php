@extends('welcome')
@section('content')



<div class="container">
	<div class="card">

		<div class="card-header"><i class="fa fa-fw fa-plus-circle">
			</i> Articulos de la categoria <strong> {{$categoria->NombreCategoria}}</strong>
			<a href="/categorias" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado de Categorias</a>
		</div>

		<div class="card-body">

			<div class="row">
				<div class="col-sm-12">
					<a href="/categorias/{{$categoria->IdCategoria}}/articulos/create" class="float-right btn btn-primary btn-sm"><i class="fa fa-fw fa-plus-circle"></i>
						Agregar Articulo</a></div>

					<table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0"
					   role="grid" aria-describedby="dataTable_info" style="width: 100%;">

					<thead>
					<tr role="row">

						<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1"
							aria-label="Position: activate to sort column ascending" style="width: 147px;">
							Id
						</th>
						<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1"
							aria-label="Office: activate to sort column ascending" style="width: 64px;">
							Articulo
						</th>
						<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1"
								 aria-label="Office: activate to sort column ascending" style="width: 64px;">
							Existencia
						</th>
						<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1"
							aria-label="Office: activate to sort column ascending" style="width: 64px;">
							Precio
						</th>
						<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1"
							aria-label="Office: activate to sort column ascending" style="width: 64px;">
							Descripción
						</th>
						<th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1"
							aria-label="Age: activate to sort column ascending" style="width: 31px;">
							Acciones
						</th>

					</tr>
					</thead>
					<tfoot>
					<tr>

						<th rowspan="1" colspan="1">Id</th>
						<th rowspan="1" colspan="1">Articulo</th>
						<th rowspan="1" colspan="1">Existencia</th>
						<th rowspan="1" colspan="1">Precio</th>
						<th rowspan="1" colspan="1">Descripción</th>
						<th rowspan="1" colspan="1"></th>
					</tr>
					</tfoot>
					<tbody>
					@foreach($categoria->articulos as $articulo)
						<tr role="row">
							<td class="col-md-1">{{$articulo->IdArticulo}}</td>
							<td class="col-md-5">{{$articulo->NombreArticulo}}  </td>
							<td class="col-md-1">{{$articulo->CantidadExistencia}}  </td>
							<td class="col-md-1">{{$articulo->PrecioVigente}}  </td>
							<td class="col-md-5">{{$articulo->Descripcion}}  </td>

							<td class="sorting_1">

								<li data-form="#delete-form-{{$articulo->IdArticulo}}"
									data-title="Eliminar categoria"
									data-message="Se encuentra seguro de eliminar este Artículo ?"
									data-target="#formConfirm" class="listado">
									<a href="/categorias/{{$articulo->IdArticulo}}/edit"
									   class="text-primary"><i class="fa fa-fw fa-edit"></i> Editar</a>
									<a data-toggle="modal" class="formConfirm text-danger" href=""
									   data-target="#formConfirm">
										<i class="fa fa-fw fa-trash"></i>
										Eliminar
									</a>

								</li>

								<form id="delete-form-{{$articulo->IdArticulo}}"
									  action="/categorias/{{$articulo->IdArticulo}}" method="post"
									  style="display: none">
									<input type="hidden" name="_method" value="delete">
									{{csrf_field()}}

								</form>

							</td>


						</tr>
					@endforeach


					</tbody>

				</table>
				</div>
			</div>d

		</div>

	</div>
</div>



@endsection
