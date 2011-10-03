EDPRPT9 ;SLC/MKB - Patient Xref Report
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
XRF(BEG,END) ; Get Patient Xref Report for EDPSITE by date range
 ;   CNT = counters
 N IN,LOG,DFN,ID,X,ROW,TAB
 D:'$G(CSV) XML^EDPX("<patients>") I $G(CSV) D  ;headers
 . S TAB=$C(9),X="ED"_TAB_"Patient ID"_TAB_"Patient DFN"
 . D ADD^EDPCSV(X)
 S IN=BEG-.000001
 F  S IN=$O(^EDP(230,"ATI",EDPSITE,IN)) Q:'IN  Q:IN>END  S LOG=0 F  S LOG=+$O(^EDP(230,"ATI",EDPSITE,IN,LOG)) Q:LOG<1  D
 . S DFN=$P($G(^EDP(230,LOG,0)),U,6),ID=$P($G(^(0)),U,11) Q:DFN<1
 . I $G(CSV) S X=LOG_TAB_ID_TAB_DFN D ADD^EDPCSV(X) Q
 . K ROW S ROW("id")=LOG
 . S ROW("patientDfn")=DFN
 . S ROW("patientId")=ID
 . S X=$$XMLA^EDPX("patient",.ROW) D XML^EDPX(X)
 D:'$G(CSV) XML^EDPX("</patients>")
 Q
