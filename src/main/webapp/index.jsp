<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Task" %>
<%@ page import="com.example.dao.TaskDAO" %>
<%
    TaskDAO taskDAO = new TaskDAO();
    List<Task> tasks = taskDAO.getAllTasks();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TODO List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .todo-item { display: flex; align-items: center; justify-content: space-between; padding: 0.5rem 0; }
        .todo-actions { display: flex; gap: 0.5rem; }
        .todo-name { flex: 1; margin-left: 1rem; }
        .todo-completed { text-decoration: line-through; color: #888; }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h2 class="mb-4 text-center">TODO List</h2>
            <form class="input-group mb-3" action="TasksServlet" method="post">
                <input type="text" class="form-control" name="taskName" placeholder="Add a new task..." required>
                <button class="btn btn-primary" type="submit" name="action" value="add"><i class="bi bi-plus-lg"></i></button>
            </form>
            <ul class="list-group">
                <% for(Task task : tasks) { %>
                <li class="list-group-item todo-item <%= task.isCompleted() ? "todo-completed" : "" %>">
                    <form action="TasksServlet" method="post" style="display:inline;">
                        <input type="hidden" name="taskId" value="<%= task.getId() %>">
                        <input type="checkbox" name="action" value="toggle" onchange="this.form.submit()" <%= task.isCompleted() ? "checked" : "" %>>
                    </form>
                    <span class="todo-name"><%= task.getName() %></span>
                    <div class="todo-actions">
                        <form action="TasksServlet" method="post" style="display:inline;">
                            <input type="hidden" name="taskId" value="<%= task.getId() %>">
                            <button class="btn btn-link p-0" type="submit" name="action" value="edit"><i class="bi bi-pencil"></i></button>
                        </form>
                        <form action="TasksServlet" method="post" style="display:inline;">
                            <input type="hidden" name="taskId" value="<%= task.getId() %>">
                            <button class="btn btn-link text-danger p-0" type="submit" name="action" value="delete"><i class="bi bi-trash"></i></button>
                        </form>
                    </div>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
