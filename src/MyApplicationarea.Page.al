page 50105 "MyApplicationarea"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Application Area Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Company Name"; Rec."Company Name") { }
                field("Profile ID"; Rec."Profile ID") { }
                field("User ID"; Rec."User ID") { }
                field(Advanced; Rec.Advanced) { }
            }
        }
    }
}