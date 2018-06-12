pageextension 123456701 "CSD ResourceListExt" extends "Resource List"
{
    layout
    {
        addlast(Content)
        {
            field("CSD Maximum Participants";"CSD Maximum Participants")
            {
                ApplicationArea = All;
                Visible = ShowMaxField;
            }
            field("CSD Resource Type";"CSD Resource Type")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage();
        
    begin
        FilterGroup(3);
        ShowType := (GetFilter(Type) = '');
        ShowMaxField := (GetFilter(Type) = format(Type::Machine));
        FilterGroup(0);

    end;
    var
        ShowMaxField: Boolean;
        ShowType: Boolean;
}