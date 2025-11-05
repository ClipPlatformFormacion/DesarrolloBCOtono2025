permissionset 50100 "SUPERCourse"
{
    Caption = 'SUPER Courses', Comment = 'ESP="SUPER Cursos"';
    Assignable = true;
    Permissions = tabledata "Courses Setup" = RIMD,
        tabledata Course = RIMD,
        tabledata "Course Edition" = RIMD,
        table Course = X,
        table "Course Edition" = X,
        table "Courses Setup" = X,
        page "Course Card" = X,
        page "Course Edition FactBox" = X,
        page "Course Edition List" = X,
        page "Course List" = X,
        page "Courses Setup" = X,
        tabledata ClipPlatform.Customer.Customer = RIMD,
        table ClipPlatform.Customer.Customer = X;
}