pageextension 123456700 "CSD ResourceCardExt" extends "Resource Card"
{
    layout
    {
        modify(Type)
        {
            trigger OnAfterValidate();
            begin
                ShowMaxField := (Type = Type::Machine);
            end;
        }
        addlast(General)
        {
            field("CSD Resource Type"; "CSD Resource Type")
            {
                ApplicationArea = All;
            }
            field("CSD Quantity Per day"; "CSD Quantity Per day")
            {
                ApplicationArea = All;
            }
        }
        addafter("Personal Data")
        {
            group("CSD Room")
            {
                Caption = 'Room';
                Visible = ShowMaxField;
                field("CSD Maximum Participants"; "CSD Maximum Participants")
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord();
    begin
        ShowMaxField := (Type = Type::Machine);
    end;

    var
        ShowMaxField: Boolean;

}