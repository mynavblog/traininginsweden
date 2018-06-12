tableextension 123456700 "CSD Resource Ext" extends Resource
{
    fields
    {
       field(123456700;"CSD Resource Type";Option)
       {
          Caption = 'Resource Type';
          OptionMembers = "Internal","External";
          OptionCaption = 'Internal,External';
       }
       field(1234567001;"CSD Maximum Participants";Integer)
       {
           Caption = 'Maximum Participants';
           MinValue = 0;
           DataClassification = ToBeClassified;
       }
       field(123456702;"CSD Quantity Per day";Decimal)
       {
           Caption = 'Quantity per day';
           DataClassification = ToBeClassified;
           MinValue =0;
       }    
       modify("Profit %")
       {
           trigger OnAfterValidate()
           begin
            rec.TestField("Unit Cost");
           end;
       }
    
    }
    
    var
        myInt : Integer;
}