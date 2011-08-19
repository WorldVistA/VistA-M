HLUTIL1 ;ALB/RJS - HL7 UTILITIES ;1/17/95  11:15
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
 ;
DAT1(X) ; Convert a FileMan date to a displayable (mm/dd/yy) format.
 Q $S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")
 ;
DAT2(Y) ; Convert a FileMan date to a displayable (mmm dd yyyy) format.
 Q:'$G(Y) ""
 N % D D^DIQ
 Q $TR(Y,"@"," ")
 ;
HLFM(Y) ; Convert a quasi HL7 formatted date to a Fileman date.
 I Y="" Q ""
 N % S Y=$TR(Y,".",""),%=$E(Y,9,14)
 Q $E(Y,1,2)-17_$E(Y,3,8)_$S(+%:+("."_%),1:"")
 ;
TASK(X) ; Is the background task currently running?
 ;  Input:   X  --  Task number for the background job
 ;  Output:  0  --  No, the job is not currently running
 ;           1  --  Yes, the job is currently running
 Q +$G(^%ZTSK(+$G(X),.1))=5
 ;
PAUSE() ; Pause for CRT output.
 ;  Input:   IOST, IOSL
 ;  Output:  0  --  Continue to display output
 ;           1  --  Quit
 Q:$E(IOST,1,2)'["C-" 0
 N DIR,DIRUT,DTOUT,DUOUT,HLJ
 F HLJ=$Y:1:(IOSL-5) W !
 S DIR(0)="E" D ^DIR
 Q $D(DIRUT)!($D(DUOUT))
EXPAND(FILE,FIELD,VALUE)        ; - returns internal data in an output format
 ; Taken from IVMUFNC w/help of CPM
 N Y,C S Y=VALUE
 I 'FILE!('FIELD)!(VALUE="") G EXPQ
 S Y=VALUE,C=$P(^DD(FILE,FIELD,0),"^",2) D Y^DIQ
EXPQ    Q Y
EVENT(EID,NODES,RESULT) ;Entry point to get event data from the Protocol file
 ;
 ;This is a subroutine call with parameter passing.  It returns each
 ;of the nodes from the Protocol file for the entry specified by EID
 ;in the array specified by the RESULT parameter
 ;
 ;Required Input Parameters
 ;     EID = The IEN of the protocol in the Protocol file for which
 ;             data is being requested
 ;   NODES = The node subscripts to be returned separated by commas.
 ;             Allowable subscripts are 15, 20, 770, 771, 772, 773
 ;             Example:  15,20,770
 ;  RESULT = The name of the array in which the nodes will be returned.
 ;             The node subscripts will be used as the array subscripts.
 ;             Example:  RESULT(15)=...
 ;
 ;Check for required parameter
 I '$G(EID)!($G(NODES)']"") Q
 I '$D(^ORD(101,EID,0)) Q
 ;Get data for nodes requested
 I NODES[15 S RESULT(15)=$G(^ORD(101,EID,15))
 I NODES[20 S RESULT(20)=$G(^ORD(101,EID,20))
 I NODES[770 S RESULT(770)=$G(^ORD(101,EID,770))
 I NODES[771 S RESULT(771)=$G(^ORD(101,EID,771))
 I NODES[772 S RESULT(772)=$G(^ORD(101,EID,772))
 I NODES[773 S RESULT(773)=$G(^ORD(101,EID,773))
 Q
