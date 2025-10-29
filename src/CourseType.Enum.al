enum 50100 "Course Type"
{
    Caption = 'Course Type', Comment = 'ESP="Tipo curso"';
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ', Comment = 'ESP=" "';
    }
    value(10; "Instructor-Lead")
    {
        Caption = 'Instructor-Lead', Comment = 'ESP="Guiado por instructor"';
    }
    value(20; "Video Tutorial")
    {
        Caption = 'Video Tutorial', Comment = 'ESP="Vídeo turorial"';
    }
}