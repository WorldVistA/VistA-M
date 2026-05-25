TIUMOBJ1 ;XAN/AJB - MEDICATION OBJECT ;Aug 29, 2025@06:55:15
 ;;1.0;TEXT INTEGRATION UTILITIES;**365,372**;Jun 20, 1997;Build 5
 ;
 ; Reference to *^XLFDT in ICR #10103
 ;
 Q
ADD(TARGET,DATA) ;
 S @TARGET@(($O(@TARGET@(""),-1)+1),0)=DATA
 Q
SETSTR(S,V,X,L) ;
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
TITLE(TARGET,P,SHOW) ;
 N DATA S DATA=$S('P("A"):"Active and Recently Expired ",P("A")=1:"Active ",1:"Recently Expired ")
 S DATA=DATA_$S('P("M"):$S(P("INP"):"Inpatient ",1:"Outpatient "),P("M")=1:"Inpatient, Outpatient and Clinic ",P("M")=2:"Inpatient ",P("M")=3:"Outpatient ",1:"")
 S DATA=DATA_$S(P("M")=4:"Clinic ",P("M")=5:"Inpatient & Clinic ",P("M")=6:"Outpatient & Clinic ",P("M")=7:"Non-VA ",1:"")_"Medications"_" ("_$S(P("SU"):"in",1:"ex")_"cluding Supplies):"
 N TIUFT D WRAP^TIUFLD(DATA,80) S TIUFT=0 F  S TIUFT=$O(TIUFT(TIUFT)) Q:'TIUFT  D ADD(.TARGET,TIUFT(TIUFT)) D:'$O(TIUFT(TIUFT)) ADD(.TARGET," ")
 I P("OB")!(P("IB")) D
 . N X I P("OB")=P("IB")!('P("IB")),P("OE")=P("IE")!('P("IE")) D  Q
 . . S X="  End Date: "_$$FMTE^XLFDT(P("OE"),"5Z") D ADD(.TARGET,$$SETSTR(X,"Start Date: "_$$FMTE^XLFDT(P("OB"),"5Z"),IOM-$L(X),$L(X)))
 . . D ADD(.TARGET," ")
 . D ADD(.TARGET,$$SETSTR("Outpatient Medications"," Inpatient Medications",IOM-22,22))
 . S X="Start Date: "_$S('P("OB"):"N/A",1:$$FMTE^XLFDT(P("OB"),"5Z")) D ADD(.TARGET,$$SETSTR(X,"Start Date: "_$$FMTE^XLFDT(P("IB"),"5Z"),IOM-$L(X),$L(X)))
 . S X="  End Date: "_$S('P("OE"):"N/A",1:$$FMTE^XLFDT(P("OE"),"5Z")) D ADD(.TARGET,$$SETSTR(X,"  End Date: "_$$FMTE^XLFDT(P("IE"),"5Z"),IOM-$L(X),$L(X)))
 . D ADD(.TARGET," ")
 I SHOW,P("SC") D ADD(.TARGET,"              WARNING              Sorting by drug class may be inaccurate.") D
 . D ADD(.TARGET,"Multi-classed medications will only be displayed under a single drug class.") I 'P("UNK") D ADD(.TARGET," ")
 I P("UNK") D ADD(.TARGET,"The system may not be able to determine the drug class of some medications."),ADD(.TARGET," ")
 Q
