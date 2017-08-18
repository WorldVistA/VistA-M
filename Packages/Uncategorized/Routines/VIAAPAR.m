VIAAPAR ;ALB/CR - RTLS Set Par Levels in GIP ;4/20/16 10:10 pm
 ;;1.0;RTLS;**4**;April 22, 2013;Build 21
 ;
 Q
 ; Access to file #445 covered by IA #5923
 ; Get unique handle ID string for ^XTMP covered by IA #4770
 ;
 ;-- get par levels (stock levels) from WaveMark and set them in a GIP IP
 ;
SETPAR(RETSTA,IPNAME,ITEM,PAR1,PAR2,PAR3,PAR4,PAR5) ;
 ; RPC: [VIAA SET PAR LEVELS IN GIP]
 ;
 ; -- input parameters:
 ;    retsta - return array that carries the call result, required
 ;    inventory point name (IP) - required
 ;    item master # - required
 ;    par levels - not all required and any can be zero or null but
 ;    not less than zero.
 ; -- output result:
 ;    stored in ^XTMP("VIAAPAR",$J,0) and passed forward via RETSTA;
 ;    contains a short message to indicate success. For a failure,
 ;    the following format is used:
 ;    "-###^"_failure_message, where '###' is a 3-digit http status
 ;    code.
 ;
 N A,FDA,ERR,VIAA,IPIEN,PAR9,PAR10,PAR11,PAR23,TIMDATE,X,Y
 ; clean up ^TMP of old data and ^XTMP if found
 S A="" F  S A=$O(^TMP(A)) Q:A=""  I $E(A,1,7)["VIAAPAR" K ^TMP(A),^XTMP(A)
 ;
 S VIAA=$$HANDLE^XUSRB4("VIAAPAR") ; get handle, prepare for entry in ^XTMP
 S $P(^XTMP(VIAA,0),U,3)="Par Levels Set up for GIP"
 S X=DT D NOW^%DTC,YX^%DTC S TIMDATE=Y  ; current date/time
 S ^TMP(VIAA,"Received_Data_From_WaveMark",TIMDATE)=IPNAME_U_ITEM_U_PAR1_U_PAR2_U_PAR3_U_PAR4_U_PAR5
 ;
 I $G(IPNAME)="" S ^XTMP(VIAA,$J,0)="-400^Inventory Point name not specified" D EXIT Q
 S IPIEN=+$O(^PRCP(445,"B",IPNAME,""))
 I 'IPIEN S ^XTMP(VIAA,$J,0)="-404^"_IPNAME_" is an invalid Inventory Point" D EXIT Q
 I ITEM=""!(+ITEM=0) S ^XTMP(VIAA,$J,0)="-400^Item Master # not specified" D EXIT Q
 I +ITEM'=ITEM S ^XTMP(VIAA,$J,0)="-400^Item Master #"_ITEM_" not found in Inventory Point "_IPNAME D EXIT Q
 ;
 I '$D(^PRCP(445,IPIEN,1,ITEM,0)) S ^XTMP(VIAA,$J,0)="-400^Item Master #"_ITEM_" not found in Inventory Point "_IPNAME D EXIT Q
 ;
 I (PAR1<0)!(PAR2<0)!(PAR3<0)!(PAR4<0)!(PAR5<0) S ^XTMP(VIAA,$J,0)="-400^A par level cannot be negative" D EXIT Q
 I (PAR1'?.N)!(PAR2'?.N)!(PAR3'?.N)!(PAR4'?.N)!(PAR5'?.N) S ^XTMP(VIAA,$J,0)="-400^Illegal par level detected - only null, zero, or a number greater than zero are allowed" D EXIT Q
 ;
 ;-- update the par levels in GIP: number designates the global piece
 ;   set during the update; translation order: par9=par1, par11=par2, ;   par10=par3, par4=par4, par23=par5
 ;
 S PAR9=PAR1,PAR11=PAR2,PAR10=PAR3,PAR23=PAR5
 ;
 S X=DT D NOW^%DTC,YX^%DTC S TIMDATE=Y  ; current date/time
 L +^PRCP(445,IPIEN,1,ITEM,0):1 I '$T S ^XTMP(VIAA,$J,0)="-423^The resource that is being accessed is locked - cannot complete par levels processing for Item Master #"_ITEM_", on "_TIMDATE D EXIT Q
 S FDA(445.01,ITEM_","_IPIEN_",",10.3)=PAR4 ; optional reorder level
 S FDA(445.01,ITEM_","_IPIEN_",",9)=PAR9    ; normal stock level
 S FDA(445.01,ITEM_","_IPIEN_",",10)=PAR10  ; std reorder level
 S FDA(445.01,ITEM_","_IPIEN_",",11)=PAR11  ; emergency stock level
 S FDA(445.01,ITEM_","_IPIEN_",",9.5)=PAR23 ; temp stock level
 D FILE^DIE("","FDA","ERR")
 L -^PRCP(445,IPIEN,1,ITEM,0)
 I $D(ERR) S ^XTMP(VIAA,$J,0)="-400^GIP par levels update not filed" D EXIT Q
 S ^XTMP(VIAA,$J,0)="1^GIP par levels update completed for IP "_IPNAME_" and Item Master #"_ITEM_" on "_TIMDATE
 ;
EXIT S RETSTA=$NA(^XTMP(VIAA,$J))
 ; save whatever we processed and answer sent to the calling app
 M ^TMP(VIAA,"Saved_Transaction_Header")=^XTMP(VIAA,0)
 M ^TMP(VIAA,"Saved_Transaction_Type: Par Levels Set up")=^XTMP(VIAA,$J)
 L -^XTMP(VIAA) ; release lock for $$HANDLE^XUSRB4 call
 Q
