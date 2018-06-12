page 123456702 "CSD Seminar List"
{
    PageType = List;
    SourceTable = "CSD Seminar";
    UsageCategory = Lists;
    ApplicationArea = All;
    caption = 'Seminar List';
    CardPageId = "CSD Seminar Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {

                }
                field(Name;Name)
                {

                }
                field("Seminar Duration";"Seminar Duration")
                {

                }
                field("Seminar Price";"Seminar Price")
                {

                }
                field("Minimum Participants";"Minimum Participants")
                {

                }
                field("Maximum Participants";"Maximum Participants")
                {

                }

            }
        }
        area(factboxes)
        {
        }
    }

    actions
    {
        area(processing)
        {
            action(ActionName)
            {
                trigger OnAction();
                begin
                end;
            }
        }
    }
}