PSOSPMB3 ;BIRM/MFR - ASAP Definitions Listman Actions Handler (Cont.) ;11/11/15
 ;;7.0;OUTPATIENT PHARMACY;**451**;DEC 1997;Build 114
 ;
DELCUS ; Handles the 'Delete Customizatoin' Action
 N CUSTYPE,DIR,DTOUT,DIRUT,VERLST,X,Y,STDASAP,CUSASAP,SEGID,ELMID,ELMPOS,SEG,ELM,DONE,STOP,I,J
 N CNT,CHILDREN,STDVDLMS,ALLVDLMS
 I PSOASVER="1995" S VALMSG="ASAP 1995 Version cannot be customized" W $C(7) G EXIT^PSOSPMA3
 I '$$SECKEY^PSOSPMA3() G EXIT^PSOSPMA3
 I '$$LOCK^PSOSPMA3() G EXIT^PSOSPMA3
 S CUSTYPE=0
 D FULL^VALM1
 K DIR S DIR("A")="Customization Selection",DIR(0)="SO^"
 S STDVDLMS=$$VERDATA^PSOSPMU0(PSOASVER,"S"),ALLVDLMS=$$VERDATA^PSOSPMU0(PSOASVER,"B")
 I STDVDLMS'="",STDVDLMS'=ALLVDLMS D
 . S DIR(0)=DIR(0)_"D:ASAP "_PSOASVER_" Delimiters (Restore);"
 S DIR(0)=DIR(0)_"V:ASAP "_PSOASVER_" Version;S:ASAP "_PSOASVER_" Segment;E:ASAP "_PSOASVER_" Data Element"
 S DIR("?")="Select the customization to be deleted."
 D ^DIR I (X="")!$D(DIRUT)!$D(DTOUT) G BACK^PSOSPMA3
 S CUSTYPE=Y
 ;
 ; Restore ASAP Version Delimiters
 I CUSTYPE="D" D  G BACK^PSOSPMA3
 . W !!,"The customization for the ASAP Version '",PSOASVER,"' delimiters will be deleted and the"
 . W !,"standard delimiters will be restored to the following:",!
 . W:$P(STDVDLMS,"^",2)'=$P(ALLVDLMS,"^",2) !?3,"Element Delimiter ('",$P(STDVDLMS,"^",2),"')"
 . W:$P(STDVDLMS,"^",3)'=$P(ALLVDLMS,"^",3) !?3,"Segment Terminator ('",$P(STDVDLMS,"^",3),"')"
 . W:$P(STDVDLMS,"^",4)'=$P(ALLVDLMS,"^",4) !?3,"End Of Line Escape (",$S($P(STDVDLMS,"^",4)="":"<NULL>",1:"'"_$P(STDVDLMS,"^",4)_"'"),")"
 . W ! S X=$$ASKFLD^PSOSPMA3("Y","NO","Confirm Deletion") I X'=1 Q
 . W ?40,"Restoring..." D SAVEVER^PSOSPMU3(PSOASVER,$$VERDATA^PSOSPMU0(PSOASVER,"S")) H 1 W "OK",$C(7)
 ;
 ; Delete ASAP Version
 I CUSTYPE="V" D  G BACK^PSOSPMA3
 . D LOADASAP^PSOSPMU0(PSOASVER,"S",.STDASAP) ; Standard ASAP Definition
 . D LOADASAP^PSOSPMU0(PSOASVER,"C",.CUSASAP) ; Custom ASAP Definition
 . I $G(STDASAP)="",$$VERINUSE(PSOASVER) D  Q
 . . W !!,"ASAP Version ",PSOASVER," is being used by ",$$GET1^DIQ(5,$$VERINUSE(PSOASVER),.01)," and cannot be deleted.",$C(7)
 . . D PAUSE^PSOSPMU1
 . W !!," ASAP Version: ",PSOASVER
 . I $G(STDASAP)'="" D
 . . W !!,"The customization for the ASAP Version '",PSOASVER,"' and all of its custom Segments,"
 . . W !,"Data Elements and Delimiters will be deleted and the standard definition"
 . . W !,"will be restored.",!
 . E  D
 . . W !!,"The custom ASAP Version '",PSOASVER,"' and all of its Segments and Data Elements"
 . . W !,"will be deleted.",!
 . I STDVDLMS'="" D
 . . W:$P(STDVDLMS,"^",2)'=$P(ALLVDLMS,"^",2) !?3,"Element Delimiter ('",$P(ALLVDLMS,"^",2),"')"
 . . W:$P(STDVDLMS,"^",3)'=$P(ALLVDLMS,"^",3) !?3,"Segment Terminator ('",$P(ALLVDLMS,"^",3),"')"
 . . W:$P(STDVDLMS,"^",4)'=$P(ALLVDLMS,"^",4) !?3,"End Of Line Escape (",$S($P(ALLVDLMS,"^",4)="":"<NULL>",1:"'"_$P(ALLVDLMS,"^",4)_"'"),")"
 . S (STOP,CNT)=3,SEG="999" F  S SEG=$O(CUSASAP(SEG)) Q:SEG=""  D  I STOP="^" Q
 . . I $$CUSSEG^PSOSPMU3(PSOASVER,SEG) W !?3,$P(CUSASAP(SEG),"^",1),?12,$P(CUSASAP(SEG),"^",2) S CNT=CNT+1
 . . S ELM=0 F  S ELM=$O(CUSASAP(SEG,ELM)) Q:'ELM  D  I STOP="^" Q
 . . . W !?3,$P(CUSASAP(SEG,ELM),"^",1),?12,$P(CUSASAP(SEG,ELM),"^",2) S CNT=CNT+1
 . . . I (CNT>22) S STOP=$$ASKFLD^PSOSPMA3("E",,"Enter <RET> to continue or '^' to STOP"),CNT=0
 . W ! S X=$$ASKFLD^PSOSPMA3("Y","NO","Confirm Deletion") I X'=1 Q
 . W ?40,"Deleting..." D DELCUS^PSOSPMU3(PSOASVER) H 1 W "OK",$C(7)
 ;
 ; Delete ASAP Segment
 I CUSTYPE="S" D  G BACK^PSOSPMA3
 . D LOADASAP^PSOSPMU0(PSOASVER,"S",.STDASAP) ; Standard ASAP Definition
 . D LOADASAP^PSOSPMU0(PSOASVER,"C",.CUSASAP) ; Custom ASAP Definition
 . W !!,"ASAP Version ",PSOASVER
 . K DIR S DIR("?",1)="Enter the Custom ASAP Segment ID that you want to delete."
 . S DIR("?",2)=" ",DIR("?",3)="   Choose from:"
 . S (STOP,CNT)=0,SEG="999",CNT=4 F  S SEG=$O(CUSASAP(SEG)) Q:SEG=""  D
 . . S DIR("?",CNT)="   "_SEG_"   "_$P(CUSASAP(SEG),"^",2),CNT=CNT+1
 . S DIR("?")=" ",DIR(0)="FO^1:5",DIR("A")="SEGMENT ID"
 . S SEGID="",DONE=0 F  W ! D ^DIR Q:($D(DIRUT)!$D(DTOUT))!(X="")  D  I DONE Q
 . . S:'$D(CUSASAP(X)) X=$$UP^XLFSTR(X) I '$D(CUSASAP(X)) W !,"Custom Segment not found!",$C(7) Q
 . . K CHILDREN I '$D(STDASAP(X)) D  I $O(CHILDREN(""))'="" Q
 . . . S SEG="999" F  S SEG=$O(CUSASAP(SEG)) Q:SEG=""  I $P(CUSASAP(SEG),"^",3)=X S CHILDREN(SEG)=""
 . . . I $O(CHILDREN(""))'="" D
 . . . . W !!,"The following custom children ASAP Segments must be deleted first:",!,$C(7)
 . . . . S SEG="" F  S SEG=$O(CHILDREN(SEG)) Q:SEG=""  W !?3,SEG,?12,$P(CUSASAP(SEG),"^",2)
 . . S SEGID=X W "   ",$P(CUSASAP(SEGID),"^",2) S DONE=1
 . I 'DONE Q
 . I $D(STDASAP(SEGID)) D
 . . W !!,"The customization for the Segment '",SEGID,"' and all of its custom Data Elements"
 . . W !,"will be deleted and the standard definition will be restored.",!
 . E  D
 . . W !!,"The custom Segment '",SEGID,"' and all of its Data Elements will be deleted.",!
 . S STOP="",(ELM,CNT)=0 F  S ELM=$O(CUSASAP(SEGID,ELM)) Q:ELM=""  D
 . . W !?3,$P(CUSASAP(SEGID,ELM),"^",1),?12,$P(CUSASAP(SEGID,ELM),"^",2) S CNT=CNT+1
 . . I (CNT>18) S STOP=$$ASKFLD^PSOSPMA3("E",,"Enter <RET> to continue or '^' to STOP"),CNT=0
 . W ! S X=$$ASKFLD^PSOSPMA3("Y","NO","Confirm Deletion") I X'=1 Q
 . W ?40,"Deleting..." D DELCUS^PSOSPMU3(PSOASVER,SEGID) H 1 W "OK",$C(7)
 ;
 ; Delete ASAP Data Element
 I CUSTYPE="E" D  G BACK^PSOSPMA3
 . D LOADASAP^PSOSPMU0(PSOASVER,"S",.STDASAP) ; Standard ASAP Definition
 . D LOADASAP^PSOSPMU0(PSOASVER,"C",.CUSASAP) ; Custom ASAP Definition
 . W !!,"ASAP Version ",PSOASVER
 . K DIR S DIR("?",1)="Enter the Custom ASAP Data Element that you want to delete."
 . S DIR("?",2)=" ",DIR("?",3)="   Choose from:"
 . S SEG="999",CNT=4 F  S SEG=$O(CUSASAP(SEG)) Q:SEG=""  D
 . . S ELM=0 F  S ELM=$O(CUSASAP(SEG,ELM)) Q:'ELM  D
 . . . S DIR("?",CNT)="   "_$P(CUSASAP(SEG,ELM),"^")_"   "_$P(CUSASAP(SEG,ELM),"^",2),CNT=CNT+1
 . S DIR("?")=" ",DIR(0)="FO^1:10",DIR("A")="DATA ELEMENT ID"
 . S DONE=0 F  W ! D ^DIR Q:($D(DIRUT)!$D(DTOUT))!(X="")  D  I DONE Q
 . . I '$D(CUSASAP($$GETSEGID^PSOSPMU3(X))) S X=$$UP^XLFSTR(X)
 . . S SEGID=$$GETSEGID^PSOSPMU3(X),ELMPOS=+$P(X,SEGID,2)
 . . I '$D(CUSASAP(SEGID,ELMPOS)) W !,"Custom Data Element not found!",$C(7) Q
 . . I $D(CUSASAP(SEGID,ELMPOS+1)),'$D(STDASAP(SEGID,ELMPOS+1)) D  Q
 . . . W !,"Only the last Custom Data Element in the Segment can be deleted.",$C(7)
 . . W "   ",$P(CUSASAP(SEGID),"^",2) S DONE=1
 . I 'DONE Q
 . I $D(STDASAP(SEGID,ELMPOS)) D
 . . W !!,"The customization for the Data Element '",$P(STDASAP(SEGID,ELMPOS),"^"),"' will be deleted and the"
 . . W !,"standard definition will be restored.",!
 . E  D
 . . W !!,"The custom Data Element '",$P(CUSASAP(SEGID,ELMPOS),"^",1),"' will be deleted.",!
 . S X=$$ASKFLD^PSOSPMA3("Y","NO","Confirm Deletion") I X'=1 Q
 . W ?40,"Deleting..." D DELCUS^PSOSPMU3(PSOASVER,SEGID,$P(CUSASAP(SEGID,ELMPOS),"^",1)) H 1 W "OK",$C(7)
 G BACK^PSOSPMA3
 ;
VERINUSE(PSOASVER) ; Verify whether the ASAP Version is in use or not
 ; Input: (r) PSOASVER - Source ASAP Version to be cloned (3.0, 4.0, 4.1, 4.2)
 ;Output: $$VERINUSE - Pointer to first the STATE file (#5) that is using the ASAP Version
 N STATE,VERINUSE
  S (STATE,VERINUSE)=0 F  S STATE=$O(^PS(58.41,STATE)) Q:'STATE  D  I VERINUSE Q
 . I $$GET1^DIQ(58.41,STATE,1,"I")=PSOASVER S VERINUSE=STATE
 Q VERINUSE
