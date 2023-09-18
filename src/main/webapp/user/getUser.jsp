<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="EUC-KR">
    <title>ȸ��������ȸ</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script type="text/javascript">
        $(function() {
            $("button#editUser").on("click", function() {
                self.location = "/user/updateUser?userId=${user.userId}";
            });
            
            $("button#confirmUser").on("click", function() {
                history.go(-1);
            });
        });
    </script>
    <style>
        .user-detail-card {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
    </style>
</head>

<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card user-detail-card">
                    <div class="card-header text-center">
                        <h4>����������ȸ</h4>
                    </div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">���̵�: ${user.userId}</li>
                            <li class="list-group-item">�̸�: ${user.userName}</li>
                            <li class="list-group-item">�ּ�: ${user.addr}</li>
                            <li class="list-group-item">�޴���ȭ��ȣ: ${ !empty user.phone ? user.phone : '����'}</li>
                            <li class="list-group-item">�̸���: ${user.email}</li>
                            <li class="list-group-item">��������: ${user.regDate}</li>
                        </ul>
                    </div>
                    <div class="card-footer d-flex justify-content-end">
                        <button id="editUser" class="btn btn-primary me-2">����</button>
                        <button id="confirmUser" class="btn btn-outline-secondary">Ȯ��</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
