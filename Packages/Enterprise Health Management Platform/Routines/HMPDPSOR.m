HMPDPSOR ;SLC/MKB,ASMR/RRB,SRG - Medication extract by order;8/2/11  15:29
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^OR(100                       5771
 ; ^ORD(100.98                    873
 ; ^SC                          10040
 ; ^VA(200                      10060
 ; DIQ                           2056
 ; ORCD                          5493
 ; ORQ1,^TMP("ORR",$J)           3154
 ; ORX8                 871,2467,3071
 ; PSOORRL,^TMP("PS",$J)         2400
 ; PSS50P7                       4662
 ; PSS51P2                       4548
 Q
 ; ------------ Get data from VistA ------------
 ;
STATUS(X) ; -- return HITSP status for 100.01 #X
 S X=+$G(X) S:'X X=99  ;no status
 I X=3 Q "hold"
 I X=10!(X=11)!(X=5) Q "not active"
 I X=1!(X=12)!(X=13) Q "not active"
 I X=14!(X=99)       Q "not active"
 I X=2!(X=7)!(X=15)  Q "historical"
 Q "active"
 ;
RESP(ORIFN,RESP) ; -- return order responses [internal form]
 N HMPDLG,I,J,W,ID,TYPE,X,Y
 I '$D(ORDIALOG) S ORDIALOG=129 D GETDLG1^ORCD(129)
 D GETORDER^ORCD(+$G(ORIFN),"HMPDLG")
 S I=0 F  S I=$O(HMPDLG(I)) Q:I<1  D
 . S ID=$P($G(ORDIALOG(I)),U,2) Q:'$L(ID)
 . S TYPE=$P($G(ORDIALOG(I,0)),U)
 . S J=0 F  S J=$O(HMPDLG(I,J)) Q:J<1  I $D(HMPDLG(I,J)) D
 .. S X=HMPDLG(I,J) I TYPE'="W" S RESP(ID,J)=X Q
 .. S Y=$G(@X@(1,0)),W=1 F  S W=$O(@X@(W)) Q:W<1  S Y=Y_$S($E(Y,$L(Y))'=" ":" ",1:"")_$G(@X@(W,0))
 .. S:$L(Y) RESP(ID,J)=Y
 Q
