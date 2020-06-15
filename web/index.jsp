<html>
<head>

    <script src="angular.min.js"></script>

    <link href="bootstrap.css" rel="stylesheet" />

    <script src="jquery.min.js"></script>
</head>
<body ng-app="UserApp" ng-controller="myController" style="background-color:wheat">
<div class="container">
    <h2>Users Record View</h2>

    <table class="table" style="background-color:aquamarine;color:black">
        <thead class="thead-dark">
        <tr>
            <th scope="col">Id</th>
            <th scope="col">Name</th>
            <th scope="col">CNIC </th>
            <th scope="col">Age</th>
            <th scope="col">Height</th>
            <th scope="col">Operation</th>
        </tr>
        </thead>
        <tbody id="tabcontent">
        <tr ng-repeat="x in data">
            <td>{{ x.ID }}</td>
            <td>{{ x.Name }}</td>
            <td>{{ x.CNIC }}</td>
            <td>{{ x.Age }}</td>
            <td>{{ x.Height }}</td>
            <td><a style="color:red" href="#" data-toggle="modal" data-target="#myModal" ng-click="displayForUpdate(x)">Edit</a>|<a style="color:red" href="#" data-toggle="modal" data-target="#myModal" ng-click="displayForRemove(x)">Delete</a></td>
        </tr>
        </tbody>
    </table>
</div>

<div class="row">
    <div class="col-12">
        <div class="modal-footer">
            <div class="container" style="background-color:aquamarine">
                <form ><center><h1>Form</h1></center>
                    <div class="form-group">
                        <label for="EmployeeId">ID</label>
                        <input type="text" class="form-control" ng-model="Person_Id" placeholder="Id" />
                    </div>
                    <div class="form-group">
                        <label for="Name">Name</label>
                        <input type="text" class="form-control" ng-model="Person_Name" placeholder="Name" />
                    </div>
                    <div class="form-group">
                        <label for="Name">CNIC</label>
                        <input type="text" class="form-control" ng-model="Person_CNIC" placeholder="CNIC" />
                    </div>
                    <div class="form-group">
                        <label for="Name">Height</label>
                        <input type="text" class="form-control" ng-model="Person_Height" placeholder="Height" />
                    </div><div class="form-group">
                        <label for="Name">Age</label>
                        <input type="text" class="form-control" ng-model="Person_Age" placeholder="Age" />
                    </div>
                </form><div class="row">
                <div class="col-12">
                    <button type="button" class="btn btn-success" data-target="myModal" data-dismiss="modal" ng-click="addNewRecord()" id="btnAdd">Add/Create</button>
                    <button type="button" class="btn btn-danger" data-bind="myModal" data-dismiss="modal" ng-click="deleteRecord()" id="btnDelete">Delete</button>
                    <button type="button" class="btn btn-primary" data-bind="myModal" data-dismiss="modal" ng-click="updateRecord()" id="btnUpdate">Update</button>
                </div>
            </div>
            </div>

        </div>
    </div>

</div>



<script>
    var myApp = angular.module('UserApp', []);
    myApp.controller("myController", function ($scope, $http) {
        //success function
        var onSuccess = function (Data, status, headers, config) {
            $scope.data = Data;
        };
        //error fuction
        var onError = function (myPrsonData, status, headers, config) {
            $scope.error = status;
        };
        $scope.displayForAdd = function () {
            $scope.operation = "Add New Record";
            $("#btnDelete").hide();
            $("#btnUpdate").hide();
        }
        //for update recored
        $scope.displayForUpdate = function (value) {
            $scope.operation = "Update Record";
            $scope.Person_Id = value.ID;
            $scope.Person_Name = value.Name;
            $scope.Person_CNIC = value.CNIC;
            $scope.Person_Height = value.Height;
            $scope.Person_Age = value.Age;
            $("#btnDelete").hide();
            $("#btnAdd").hide();
        }
        //delete function
        $scope.displayForRemove = function (value) {
            $scope.operation = "Remove Record";
            $scope.Person_Id = value.ID;
            $scope.Person_Name = value.Name;
            $scope.Person_CNIC = value.CNIC;
            $scope.Person_Height = value.Height;
            $scope.Person_Age = value.Age;
            $("#btnUpdate").hide();
            $("#btnAdd").hide();
        }
        //add record
        $scope.addNewRecord = function () {
            var person = {
                "ID": $scope.Person_Id,
                "Name": $scope.Person_Name,
                "CNIC": $scope.Person_CNIC,
                "Age": $scope.Person_Age,
                "Height": $scope.Person_Height
            };
            //create/add record
            var promise = $http.post('http://exampleapi.somee.com/api/person/', person);
            promise.success(function (data, status, headers, config) {
                $scope.data = data;
                resetOptions();
            });
            promise.error(function (data, status, headers, config) {
                alert("error occured while sending ajax request");
            });
        }
        //for delete record
        $scope.deleteRecord = function () {
            var promise = $http.delete('http://exampleapi.somee.com/api/person/' + $scope.Person_Id);
            promise.success(function (data, status, headers, config) {
                $scope.data = data;
                resetOptions();
            });
            promise.error(function (data, status, headers, config) {
                alert("error occured while sending ajax request");
            });
        }
        //for update/edit record
        $scope.updateRecord = function () {
            var person = {
                "ID": $scope.Person_Id,
                "Name": $scope.Person_Name,
                "CNIC": $scope.Person_CNIC,
                "Age": $scope.Person_Age,
                "Height": $scope.Person_Height
            };
            var promise = $http.put('http://exampleapi.somee.com/api/person/' + $scope.Person_Id, person);
            promise.success(function (data, status, headers, config) {
                $scope.data = data;
                resetOptions();
            });
            promise.error(function (data, status, headers, config) {
                alert("error occured while sending ajax request");
            });
        }
        resetOptions = function () {
            $("#btnDelete").show();
            $("#btnAdd").show();
            $("#btnUpdate").show();
        }
        //for get  record
        var promise = $http.get("http://exampleapi.somee.com/api/person");
        promise.success(onSuccess);
        promise.error(onError);
    });
</script>
</body>
</html>
