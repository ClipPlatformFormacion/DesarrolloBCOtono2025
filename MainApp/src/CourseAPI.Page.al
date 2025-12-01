page 50107 "CourseAPI"
{
    PageType = API;
    Caption = 'courseAPI', Locked = true;
    ODataKeyFields = SystemId;
    APIPublisher = 'clipplatform';
    APIGroup = 'courseManagement';
    APIVersion = 'v1.0';
    EntityName = 'course';
    EntitySetName = 'courses';
    SourceTable = Course;
    DelayedInsert = true;
    InsertAllowed = true;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field(systemID; Rec.SystemId) { }
                field(no; Rec."No.") { }
                field(name; Rec.Name) { NotBlank = true; }
                field(price; Rec.Price) { }
            }
        }
    }

    [ServiceEnabled]
    procedure UpdatePrice(var ActionContext: WebServiceActionContext)
    begin
        Rec.Validate(Rec.Price, Rec.Price + 100);
        Rec.Modify(true);

        ActionContext.SetObjectType(ObjectType::Table);
        ActionContext.SetObjectId(Database::Course);
        ActionContext.AddEntityKey(Rec.FieldNo("No."), Rec."No.");
        ActionContext.SetResultCode(WebServiceActionResultCode::Updated);
    end;
}