KMPDTU02 ;OAK/RAK - CP Tools Compile & File Daily Timing Stats ;2/17/04  09:43
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
DAILY ;(KMPDST,KMPDEN);-entry point
 ;-----------------------------------------------------------------------
 ; KMPDST... Start date in internal fileman format.
 ; KMPDEN... End date in internal fileman format.
 ;
 ; This API gathers Timing data from ^KMPTMP("KMPDT") and stores it in
 ; file 8973.2 (CP TIMING)
 ;
 ;-----------------------------------------------------------------------
 ;
 ;Q:'$G(KMPDST)
 ;Q:'$G(KMPDEN)
 ; make sure end date has hours
 ;S:'$P(KMPDEN,".",2) $P(KMPDEN,".",2)="99"
 ;S:'$G(DT) DT=$$DT^XLFDT
 ;
 W:'$D(ZTQUEUED) !,"Compiling Timing data..."
 D COMPILE
 ;
 Q
 ;
COMPILE ;-- compile & file timing data
 ;
 Q:$O(^KMPTMP("KMPDT",""))=""
 N COUNT,DATA,DATA1,ID,OK,SBSCR,TODAY
 S TODAY=$P($H,",") Q:'TODAY
 S SBSCR="",COUNT=0
 F  S SBSCR=$O(^KMPTMP("KMPDT",SBSCR)) Q:SBSCR=""  S ID="" D 
 .F  S ID=$O(^KMPTMP("KMPDT",SBSCR,ID)) Q:ID=""  S DATA=^(ID) D 
 ..; quit if not 'previous' to DT
 ..Q:$P($P(DATA,U),".")'<TODAY
 ..; set up DATA1 for filing
 ..; identifier
 ..S $P(DATA1,U)=ID
 ..; server start date/time in internal fileman format
 ..S $P(DATA1,U,3)=$$HTFM^XLFDT($P(DATA,U))
 ..; server delta
 ..S:$P(DATA,U,2) $P(DATA1,U,4)=$$HDIFF^XLFDT($P(DATA,U,2),$P(DATA,U),2)
 ..; person
 ..S $P(DATA1,U,5)=$P(DATA,U,3)
 ..; client name
 ..S $P(DATA1,U,6)=$P(DATA,U,4)
 ..; kmptmp subscript
 ..S $P(DATA1,U,7)=SBSCR
 ..; title
 ..S $P(DATA1,U,8)=$$TITLEG(SBSCR)
 ..; ip address
 ..S $P(DATA1,U,9)=$P($P(ID,"-")," ",2)
 ..; file data
 ..D FILE(DATA1,.OK)
 ..; update counter if successfully filed
 ..S:OK COUNT=COUNT+1
 ..; kill of old node if successfully filed
 ..K:OK ^KMPTMP("KMPDT",SBSCR,ID)
 ..I '$D(ZTQUEUED) W:'(COUNT#100) "."
 ;
 W:'$D(ZTQUEUED) !,COUNT," records filed!"
 ;
 Q
 ;
FILE(DATA,KMPDOK) ;-- file timing data into file #8973.2
 ;-----------------------------------------------------------------------
 ; DATA.... Data to file in format:
 ;          piece "^" 1 - id
 ;                    3 - start date/time in internal fileman format
 ;                    4 - delta
 ;                    5 - new person
 ;                    6 - client name
 ;                    7 - kmptmp subscript
 ;                    8 - title
 ;                    9 - ip address
 ;
 ; KMPDOK.. Returned
 ;            0 - not filed successfully
 ;            1 - filed successfully
 ;-----------------------------------------------------------------------
 ;
 S KMPDOK=0
 Q:$G(DATA)=""
 ; id
 Q:$P(DATA,U)=""
 ; start date/time
 Q:$P(DATA,U,3)=""
 ;
 N ERROR,FDA,I,IEN,ZIEN
 ; build fda() array for filing
 F I=1:1:9 I $P(DATA,U,I)'="" D 
 .S FDA($J,8973.2,"+1,",(I*.01))=$P(DATA,U,I)
 ; quit if no fda() array
 Q:'$D(FDA($J))
 ; file data
 D UPDATE^DIE("","FDA($J)","ZIEN","ERROR")
 ; if error
 I $D(ERROR) D MSG^DIALOG("HA",.ERROR,60,5,"ERROR") Q
 S KMPDOK=1
 ;
 Q
 ;
TITLEG(SBSCR) ;-- extrinsic function - return title name
 Q:$G(SBSCR)="" ""
 N I,TITLE,X S TITLE=""
 F I=1:1 S X=$T(TITLE+I) Q:X=""  I $P(X,";",3)=SBSCR S TITLE=$P(X,";",4) Q
 Q TITLE
 ;
TITLE ;-- convert subscript to title
 ;;ORWCV;CPRS Cover Sheet
