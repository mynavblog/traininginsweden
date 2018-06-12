codeunit 123456739 EventSubscriptions
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 2-1
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Res. Jnl.-Post Line", 'OnBeforeResLedgEntryInsert', '', true, true)]
    local procedure PostResJnlLineOnBeforeResLedgEntryInsert(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line");
    var
        c: Codeunit "Res. Jnl.-Post Line";
    begin
        ResLedgerEntry."CSD Seminar No." := ResJournalLine."CSD Seminar No.";
        ResLedgerEntry."CSD Seminar Registration No." := ResJournalLine."CSD Seminar Registration No.";
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', true, true)]
    local procedure ExtendNavigateOnAfterNavigateFindRecords(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text);
    var
        SeminarLedgerEntry: record "Seminar Ledger Entry";
        PostedSeminarRegHeader: record "Posted Seminar Reg. Header";
        DocNoOfRecords: Integer;
        NextEntryNo: Integer;
    begin
        if PostedSeminarRegHeader.ReadPermission then begin
            PostedSeminarRegHeader.Reset;
            PostedSeminarRegHeader.Setfilter("No.", DocNoFilter);
            PostedSeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);
            DocNoOfRecords := PostedSeminarRegHeader.Count;
        end;
        With DocumentEntry do
        begin
            if DocNoOfRecords = 0 then exit;
            if FindLast then NextEntryNo := "Entry No." + 1
            else
                NextEntryNo := 1;
            Init;
            "Entry No." := NextEntryNo;
            "Table ID" := Database::"Posted Seminar Reg. Header";
            "Document Type" := 0;
            "Table Name" := COPYSTR(PostedSeminarRegHeader.TableCaption, 1, MAXSTRLEN("Table Name"));
            "No. of Records" := DocNoOfRecords; Insert;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateShowRecords', '', true, true)]
    local procedure ExtendNavigateOnAfterNavigateShowRecords(TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean);
    var
        SeminarLedgerEntry: record "Seminar Ledger Entry";
        PostedSeminarRegHeader: record "Posted Seminar Reg. Header";

    begin
        case TableID of
      Database::"Posted Seminar Reg. Header" :
        Page.Run(0, PostedSeminarRegHeader);
        Database::"Seminar Ledger Entry" :
        Page.Run(0, SeminarLedgerEntry);
        end;
    end;
}
