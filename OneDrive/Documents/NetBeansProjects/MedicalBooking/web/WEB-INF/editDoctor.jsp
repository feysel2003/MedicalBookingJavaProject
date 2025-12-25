<%@ page import="model.Doctor" %>
<%
    Doctor d = (Doctor) request.getAttribute("doctor");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Doctor</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">

<h2>Edit Doctor</h2>

<form action="UpdateDoctorServlet" method="post">
    <input type="hidden" name="id" value="<%=d.getId()%>">

    <div class="mb-2">
        <label>Full Name</label>
        <input type="text" name="fullName" value="<%=d.getFullName()%>" class="form-control">
    </div>

    <div class="mb-2">
        <label>Email</label>
        <input type="email" name="email" value="<%=d.getEmail()%>" class="form-control">
    </div>

    <div class="mb-2">
        <label>Specialization</label>
        <input type="text" name="specialization" value="<%=d.getSpecialization()%>" class="form-control">
    </div>

    <div class="mb-2">
        <label>Phone</label>
        <input type="text" name="phone" value="<%=d.getPhone()%>" class="form-control">
    </div>

    <button class="btn btn-primary">Update</button>
    <a href="ManageDoctorsServlet" class="btn btn-secondary">Cancel</a>
</form>

</body>
</html>
