table 123456701 "CSD Seminar"
{
    DataClassification = ToBeClassified;
    Caption = 'Seminar';
    DrillDownPageId = "CSD Seminar List";
    LookupPageId = "CSD Seminar List";

    fields
    {
        field(10; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';

            trigger OnValidate();

            begin
                if "No." <> xRec."No." then begin
                    CSDSeminarSetup.get;
                    NoSeriesManagement.TestManual(CSDSeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end;

            end;
        }
        field(20; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
            trigger OnValidate();
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;

            end;
        }
        field(30; "Seminar Duration"; Decimal)
        {
            DecimalPlaces = 0 : 1;
            Caption = 'Seminar Duration';
        }
        field(40; "Minimum Participants"; Integer)
        {
            MinValue = 0;
            Caption = 'Minimum Participants';
        }
        field(50; "Maximum Participants"; Integer)
        {
            MinValue = 0;
            Caption = 'Maximum Participants';
        }
        field(60; "Search Name"; Code[50])
        {

            DataClassification = ToBeClassified;
            Caption = 'Search Name';
        }
        field(70; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(80; "Last Date Modified"; Date)
        {
            Editable = false;
            Caption = 'Last Date Modified';
        }
        field(90; Comment; Boolean)
        {
            Editable = false;
        }
        field(100; "Seminar Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Seminar Price';
        }
        field(110; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                if "Gen. Prod. Posting Group" <> xRec."Gen. Prod. Posting Group" then;
                    if GenProductPostingGroup.ValidateVatProdPostingGroup(GenProductPostingGroup, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group",GenProductPostingGroup."Def. VAT Prod. Posting Group");

            end;
        }
        field(120; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            DataClassification = ToBeClassified;
        }
        field(130; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Secondary; "Search Name")
        {

        }
    }


    trigger OnInsert();
    begin
        if "No." = '' then begin
            CSDSeminarSetup.get;
            CSDSeminarSetup.TestField("Seminar Nos.");
            NoSeriesManagement.InitSeries(CSDSeminarSetup."Seminar Nos.",xRec."No. Series",0D,"No.","No. Series");
        end;

    end;

    trigger OnModify();
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnDelete();
    begin
        //delete comments.
    end;

    trigger OnRename();
    begin
        "Last Date Modified" := Today;
    end;

    procedure AssistEdit() : Boolean;
    var
        CSDSeminar: Record "CSD Seminar";
    begin
        with CSDSeminar do
        begin
            CSDSeminar := Rec;
            CSDSeminarSetup.GET;
            CSDSeminarSetup.TestField("Seminar Nos.");
            if NoSeriesManagement.SelectSeries(CSDSeminarSetup."Seminar Nos.", xRec."No. Series", "No. Series") then begin
                NoSeriesManagement.SetSeries("No.");
                Rec := CSDSeminar;
                exit(true);
            end;
        end;
    end;

    var
        CSDSeminarSetup: Record "CSD Seminar Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        GenProductPostingGroup: Record "Gen. Product Posting Group";
}