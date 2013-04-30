LRWU8A ;DALOI/TCK - TOOL TO FIX ORGANISM SUBFILE & DATA-PART 2 ;06/18/12  13:32
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 ;-----------------------------------------------------------
ASK() ; Run analyze/repair query.
 ;
 N Y,DIRUT,DTOUT,DUOUT,FIX
 ;
 K DIR,Y
 S FIX=0
 ;
 W !,"This process will check the Organism Sub-field (#63.3) of"
 W !,"the LAB DATA file (#63) looking for possible discrepancies"
 W !,"in the Data Dictionary. Once the process has completed, a"
 W !,"MailMan message will be sent to the user that started this"
 W !,"process and any other user selected."
 W !!
 W !,"The two modes in which this process can be run are ANALYZE"
 W !,"and REPAIR. If the ANALYZE option is chosen, the process will"
 W !,"only look for the discrepancies and report the findings via"
 W !,"a MailMan message. If the ANALYZE/REPAIR option is chosen the"
 W !,"process will ANALYZE and REPAIR any discrepancies found that"
 W !,"can be fixed programmatically and list all those that could"
 W !,"not be fixed but need attention."
 W !!
 ;
 S DIR("A")="Do you want to continue with this process",DIR("B")="N"
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR
 I 'Y Q FIX
 ;
 K DIR,Y
 ;
 S DIR(0)="NAO^1:3",DIR("B")=3
 S DIR("A",1)="Select the action you wish to take:"
 S DIR("A",2)=""
 S DIR("A",3)="1. Analyze and Report. "
 S DIR("A",4)="2. Analyze, Repair and Report. "
 S DIR("A",5)="3. Quit - No Action."
 S DIR("A",6)=""
 S DIR("A")="Enter a number 1 thru 3: "
 S DIR("?")="Select a number from 1 thru 3 or press <Return> to exit"
 ;
 D ^DIR
 I Y=1 S FIX=1
 I Y=2 S FIX=2
 I Y=3!(Y=-1) S FIX=0 Q FIX
 ;
 K DIR,Y
 S DIR("A")="Are you sure you want to proceed",DIR("B")="N"
 S DIR(0)="Y",DIR("B")="NO"
 ;
 D ^DIR
 I 'Y S FIX=0
 ;-----
 Q FIX
 ;-----------------------------------------------------------
SEND ; Send the report/email to all recipients selected.
 ;
 N DSH,ERROR,FLDN,HDR,INTERP,LN,LRSITE,MSG,NFLD,NFX,NINT
 N NKEY,NSCR,NUM,OKEY,SCRN,SP,TMP,TOTAL,XMDUZ,XMSUB,DIFROM,XMINSTR
 ;
 S (XMSUB,XMDUZ,MSG,LN,ERROR,NUM)=""
 S LRSITE=$$STA^XUAF4($$KSP^XUPARAM("INST"))
 ;
 S XMINSTR("ADDR FLAGS")="R"
 S XMSUB="LAB DATA file (#63) Microbiology Antibiotic Fields Cleanup"
 S $P(SP," ",80)="",$P(DSH,"-",80)=""
 ;
 ; Not all errors were auto-repaired
 I '+$G(FIX)!(+$G(FIX)&($D(^TMP("LR",$J,"S6")))) D
 .S MSG($$LN)="Contact the National Service Desk to request assistance from the Clin 4"
 .S MSG($$LN)="Product Support team in resolving the following errors identified in the"
 .S MSG($$LN)="VistA Laboratory package:"
 .S MSG($$LN)=""
 ;
 S MSG($$LN)="The LAB DATA file (#63) cleanup process has completed."
 S MSG($$LN)=""
 S TMP="Tool run in ANALYZE"_$S(FIX:"/REPAIR",1:"")_" MODE for: "
 S MSG($$LN)=TMP_$$NAME^XUAF4($$KSP^XUPARAM("INST"))_" ("_$$KSP^XUPARAM("WHERE")_")."
 S MSG($$LN)=""
 S TMP="This process checked the Organism Sub-field (#63.3) of the "
 S MSG($$LN)=TMP_"LAB DATA file (#63)"
 S TMP="to locate potential Data Dictionary discrepancies related to "
 S MSG($$LN)=TMP_"the definition and"
 S MSG($$LN)="setup of fields for reporting antibiotic sensitivities."
 S MSG($$LN)=""
 S MSG($$LN)="The following report lists any discrepancies found:"
 S MSG($$LN)=$TR(SP," ","-")
 S MSG($$LN)=""
 I '$D(^TMP("LR",$J)) D  Q
 .S MSG($$LN)="*** NO DISCREPANCIES WERE FOUND IN FILE (#63). ***"
 .D SENDMSG^XMXAPI(DUZ,XMSUB,"MSG",.XMY,.XMINSTR)
 F TYP="S1","S2","S3","S4","S5","S6"  D
 .D BLDARY(TYP)
 .I '$D(ARY(TYP)) Q
 .S MSG($$LN)=HDR
 .S MSG($$LN)=$TR(SP," ","-")
 .I TYP="S1" D
 ..I 'FIX D
 ...S TMP=$E("ANTIBIOTIC NAME"_SP,1,33)
 ...S TMP=TMP_$E("CURRENT INPUT"_SP,1,30)_"PROPOSED INPUT"
 ...S MSG($$LN)=TMP
 ..I FIX D
 ...S TMP=$E("ANTIBIOTIC NAME"_SP,1,33)
 ...S TMP=TMP_$E("FORMER INPUT"_SP,1,30)_"NEW INPUT"
 ...S MSG($$LN)=TMP
 ..S TMP=$E(" (FIELD NUMBER)"_SP,1,33)
 ..S TMP=TMP_$E("TRANSFORM"_SP,1,30)_"TRANSFORM"
 ..S MSG($$LN)=TMP
 ..S TMP=$E(DSH,1,31)_$E(SP,1,2)_$E(DSH,1,28)_$E(SP,1,2)
 ..S MSG($$LN)=TMP_$E(DSH,1,15)
 ..S CNT="" F  S CNT=$O(ARY(TYP,CNT)) Q:CNT=""  D
 ...D GETDATA(TYP,CNT,.ANTIB,.OLDIT,.NEWIT,.IEN)
 ...S MSG($$LN)=$E(ANTIB_SP,1,33)_$E(OLDIT_SP,1,30)_$E(NEWIT_SP,1,15)
 ...S MSG($$LN)=$E(" ("_IEN_")"_SP,1,20)
 ...S TOTAL=CNT
 ..S MSG($$LN)=$TR(SP," ","-")
 ..S MSG($$LN)=$E("TOTAL: "_SP,1,7)_$E(TOTAL_SP,1,10)
 ..S MSG($$LN)=""
 ..S MSG($$LN)=""
 .I TYP="S2" D
 ..I 'FIX D
 ...S TMP=$E("ANTIBIOTIC NAME"_SP,1,33)
 ...S TMP=TMP_$E("CURRENT"_SP,1,30)_"PROPOSED"
 ...S MSG($$LN)=TMP
 ..I FIX D
 ...S TMP=$E("ANTIBIOTIC NAME"_SP,1,33)
 ...S MSG($$LN)=TMP_$E("FORMER"_SP,1,30)_"NEW"
 ..S TMP=$E(" (FIELD NUMBER)"_SP,1,33)_$E("HELP"_SP,1,30)_"HELP"
 ..S MSG($$LN)=TMP
 ..S TMP=$E(DSH,1,31)_$E(SP,1,2)_$E(DSH,1,28)_$E(SP,1,2)_$E(DSH,1,15)
 ..S MSG($$LN)=TMP
 ..S CNT="" F  S CNT=$O(ARY(TYP,CNT)) Q:CNT=""  D
 ...D GETDATA(TYP,CNT,.ANTIB,.OHLP,.NHLP,.IEN)
 ...S MSG($$LN)=$E(ANTIB_SP,1,33)_$E(OHLP_SP,1,30)_$E(NHLP_SP,1,15)
 ...S MSG($$LN)=$E(" ("_IEN_")"_SP,1,20)
 ...S TOTAL=CNT
 ..S MSG($$LN)=$TR(SP," ","-")
 ..S MSG($$LN)=$E("TOTAL: "_SP,1,7)_$E(TOTAL_SP,1,10)
 ..S MSG($$LN)=""
 ..S MSG($$LN)=""
 .I TYP="S3" D
 ..I 'FIX D
 ...S TMP=$E("ANTIBIOTIC NAME"_SP,1,33)
 ...S MSG($$LN)=TMP_$E("CURRENT"_SP,1,20)_"PROPOSED"
 ..I FIX D
 ...S TMP=$E("ANTIBIOTIC NAME"_SP,1,33)
 ...S MSG($$LN)=TMP_$E("FORMER"_SP,1,20)_"NEW"
 ..S TMP=$E(" (FIELD NUMBER)"_SP,1,33)_$E("SET OF CODES"_SP,1,20)
 ..S TMP=TMP_"SET OF CODES"
 ..S MSG($$LN)=TMP
 ..S TMP=$E(DSH,1,31)_$E(SP,1,2)_$E(DSH,1,18)_$E(SP,1,2)_$E(DSH,1,25)
 ..S MSG($$LN)=TMP
 ..S CNT="" F  S CNT=$O(ARY(TYP,CNT)) Q:CNT=""  D 
 ...D GETDATA(TYP,CNT,.ANTIB,.OKEY,.NKEY,.IEN)
 ...S MSG($$LN)=$E(ANTIB_SP,1,31)_"  "_$E(OKEY_SP,1,18)_"  "_$E(NKEY_SP,1,25)
 ...S MSG($$LN)=$E(" ("_IEN_")"_SP,1,31)_"  "_$S($L(OKEY)>18:$E(OKEY_SP,19,36),1:$E(SP,19,36))_"  "_$E(NKEY,26,44)
 ...S MSG($$LN)=$E(SP,1,33)_$S($L(OKEY)>36:$E(OKEY_SP,37,54),1:$E(SP,37,54))_"  "_$E(NKEY,45,53)
 ...I $L(OKEY)>54 D
 ....N LGOKEY,ADLOKEY,LLNOKEY,PADLOKEY
 ....S LGOKEY=$L(OKEY)-54,ADLOKEY=LGOKEY\18,LLNOKEY=LGOKEY/18
 ....S LLNOKEY=$S(LLNOKEY[".":1,1:0),PADLOKEY=0
 ....I ADLOKEY>=1 D
 .....F PADLOKEY=1:1:ADLOKEY D
 ......S MSG($$LN)=$E(SP,1,33)_$E(OKEY_SP,(18*PADLOKEY)+37,(18*PADLOKEY)+54)
 ....I LLNOKEY D
 .....S MSG($$LN)=$E(SP,1,33)_$E(OKEY_SP,(18*(ADLOKEY+1))+37,(18*(PADLOKEY+1))+54)
 ...S TOTAL=CNT
 ..S MSG($$LN)=$TR(SP," ","-")
 ..S MSG($$LN)=$E("TOTAL: "_SP,1,7)_$E(TOTAL_SP,1,10)
 ..S MSG($$LN)=""
 ..S MSG($$LN)=""
 .I TYP="S4" D
 ..S TMP=$E("ANTIBIOTIC NAME"_SP,1,33)_$E("INTERP FIELD"_SP,1,30)
 ..S TMP=TMP_"SCREEN FIELD"
 ..S MSG($$LN)=TMP
 ..S TMP=$E(" (FIELD NUMBER)"_SP,1,33)
 ..S TMP=TMP_$E($S('FIX:"NEEDED",1:"ADDED")_SP,1,30)
 ..S TMP=TMP_$S('FIX:"NEEDED",1:"ADDED")
 ..S MSG($$LN)=TMP
 ..S TMP=$E(DSH,1,31)_$E(SP,1,2)_$E(DSH,1,28)_$E(SP,1,2)_$E(DSH,1,15)
 ..S MSG($$LN)=TMP
 ..S CNT="" F  S CNT=$O(ARY(TYP,CNT)) Q:CNT=""  D
 ...D GETDATA(TYP,CNT,.ANTIB,.INTERP,.SCRN,.IEN)
 ...S MSG($$LN)=$E(ANTIB_SP,1,33)_$E(INTERP_SP,1,30)_$E(SCRN_SP,1,15)
 ...S MSG($$LN)=$E(" ("_IEN_")"_SP,1,20)
 ...S TOTAL=CNT
 ..S MSG($$LN)=$TR(SP," ","-")
 ..S MSG($$LN)=$E("TOTAL: "_SP,1,7)_$E(TOTAL_SP,1,10)
 ..S MSG($$LN)=""
 ..S MSG($$LN)=""
 .I TYP="S5" D
 ..I 'FIX D
 ...S TMP=$E("ANTIBIOTIC NAME"_SP,1,28)
 ...S TMP=TMP_$E("NEW FIELD #"_SP,1,13)_$E("NEW INTERP"_SP,1,13)
 ...S MSG($$LN)=TMP_$E("NEW SCREEN"_SP,1,13)_$E("OCCURRENCES"_SP,1,11)
 ..I FIX D
 ...S TMP=$E("ANTIBIOTIC NAME"_SP,1,28)
 ...S TMP=TMP_$E("FIELD ADDED"_SP,1,13)_$E("INTERP ADDED"_SP,1,14)
 ...S MSG($$LN)=TMP_$E("SCRN ADDED"_SP,1,12)_$E("OCCURRENCES"_SP,1,11)
 ..S TMP=$E(" (FIELD NUMBER)"_SP,1,67)_"FOUND"
 ..S MSG($$LN)=TMP
 ..S TMP=$E(DSH,1,26)_$E(SP,1,2)_$E(DSH,1,11)_$E(SP,1,2)_$E(DSH,1,12)
 ..S MSG($$LN)=TMP_$E(SP,1,2)_$E(DSH,1,11)_$E(SP)_$E(DSH,1,11)
 ..S CNT="" F  S CNT=$O(ARY(TYP,CNT)) Q:CNT=""  D
 ...D GETDATA(TYP,CNT,.ANTIB,.IEN,.NFLD,.NINT,.NSCR,.NFX)
 ...S TMP=$E(ANTIB_SP,1,28)_$E(NFLD_SP,1,13)_$E(NINT_SP,1,14)
 ...S MSG($$LN)=TMP_$E(NSCR_SP,1,13)_$E(NFX_SP,1,4)
 ...S MSG($$LN)=$E(" ("_IEN_")"_SP,1,20)
 ...S TOTAL=CNT
 ..S MSG($$LN)=$TR(SP," ","-")
 ..S MSG($$LN)=$E("TOTAL: "_SP,1,7)_$E(TOTAL_SP,1,10)
 ..I FIX D
 ...S MSG($$LN)=""
 ...S TMP="     Note: Due to the added antibiotics, updates may"
 ...S MSG($$LN)=TMP
 ...S TMP="           need to be made to input (edit) templates"
 ...S MSG($$LN)=TMP
 ...S TMP="           in the LAB DATA file that correspond to the"
 ...S MSG($$LN)=TMP
 ...S TMP="           old fields and update the new fields."
 ...S MSG($$LN)=TMP
 ..S MSG($$LN)=""
 ..S MSG($$LN)=""
 .I TYP="S6" D
 ..S MSG($$LN)=$E("ANTIBIOTIC"_SP,1,33)_$E("FIELD NUMBER",1,20)
 ..S MSG($$LN)=$E(DSH,1,31)_$E(SP,1,2)_$E(DSH,1,20)
 ..S CNT="" F  S CNT=$O(ARY(TYP,CNT)) Q:CNT=""  D
 ...D GETDATA(TYP,CNT,.ANTIB,.FLDN)
 ...S MSG($$LN)=$E(ANTIB_SP,1,33)_$E(FLDN_SP,1,30)
 ...S TOTAL=CNT
 ..S MSG($$LN)=$TR(SP," ","-")
 ..S MSG($$LN)=$E("TOTAL: "_SP,1,7)_$E(TOTAL_SP,1,10)
 .S MSG($$LN)=""
 .S MSG($$LN)=""
 K ARY
 S MSG($$LN)=$TR(SP," ","*")
 S MSG($$LN)="*** END OF REPORT ***"
 D SENDMSG^XMXAPI(DUZ,XMSUB,"MSG",.XMY,.XMINSTR)
 ;
 Q
 ;-----------------------------------------------------------
LN() ; Increment the line couter.
 ;
 S LN=LN+1
 ;
 Q LN
 ;-----------------------------------------------------------
GETDATA(TYP,CNT,A1,A2,A3,A4,A5,A6) ; Set up variables for print.
 ;
 N I,NUM
 ;
 S NUM=$L(ARY(TYP,CNT),"|")
 F I=1:1:NUM S @("A"_I)=$P(ARY(TYP,CNT),"|",I)
 ;
 Q
 ;
 ;-----------------------------------------------------------
BLDARY(TYP) ; Build the array.
 ;
 N ANTIB,IEN,MDE,NEWIT,NFLDN,NHLP,OFLN,OLDIT,OHLP,TMP
 ;
 S (ANTIB,OLDIT)="",NEWIT="D ^LRMISR",CNT=0,IEN=""
 I TYP="S1" S HDR="INCORRECT INPUT TRANSFORMS (IT)"
 I TYP="S2" S HDR="INCORRECT HELP TEXT"
 I TYP="S3" S HDR="INCORRECT SET OF CODES"
 I TYP="S4" S HDR="MISSING INTERP and/or SCREEN"
 I TYP="S5" D
 . S HDR="BAD FIELD NUMBER and DEFINITION, LAB DATA "
 . S HDR=HDR_$S('FIX:"NOT ",1:"")_"UPDATED"
 I TYP="S6" S HDR="ANTIBIOTICS NEEDING MANUAL REVIEW/UPDATE"
 I 'FIX S HDR="ANALYZE - "_HDR
 I FIX S HDR="ANALYZE/REPAIR - "_HDR
 F  S IEN=$O(^TMP("LR",$J,TYP,IEN)) Q:IEN=""  D
 .I FIX,TYP="S5" D
 ..S TMP=$P($G(^TMP("LR",$J,TYP,IEN)),U),ANTIB=$P(^DD(63.3,TMP,0),U)
 .E  S ANTIB=$P(^DD(63.3,IEN,0),U)
 .I TYP="S1" D
 ..S CNT=CNT+1
 ..S OLDIT=$P($G(^TMP("LR",$J,TYP,IEN)),"|")
 ..S NEWIT=$P($G(^TMP("LR",$J,TYP,IEN)),"|",2)
 ..S ARY(TYP,CNT)=ANTIB_"|"_OLDIT_"|"_NEWIT_"|"_IEN
 .I TYP="S2" D
 ..S CNT=CNT+1
 ..S OHLP=$P($G(^TMP("LR",$J,TYP,IEN)),"|")
 ..S NHLP=$P($G(^TMP("LR",$J,TYP,IEN)),"|",2)
 ..S ARY(TYP,CNT)=ANTIB_"|"_OHLP_"|"_NHLP_"|"_IEN
 .I TYP="S3" D
 ..S CNT=CNT+1
 ..S OKEY=$P($G(^TMP("LR",$J,TYP,IEN)),"|")
 ..S NKEY=$P($G(^TMP("LR",$J,TYP,IEN)),"|",2)
 ..S ARY(TYP,CNT)=ANTIB_"|"_OKEY_"|"_NKEY_"|"_IEN
 .I TYP="S4" D
 ..S CNT=CNT+1
 ..S INTERP=$P($G(^TMP("LR",$J,TYP,IEN)),U)
 ..S SCRN=$P($G(^TMP("LR",$J,TYP,IEN)),U,2)
 ..S ARY(TYP,CNT)=ANTIB_"|"_INTERP_"|"_SCRN_"|"_IEN
 .I TYP="S5" D
 ..S CNT=CNT+1
 ..S OFLN=IEN
 ..I 'FIX S (NFLDN,NINT,NSCR)="TBD"
 ..I FIX D
 ...S NFLDN=$P($G(^TMP("LR",$J,TYP,IEN)),U)
 ...S NINT=$P($G(^TMP("LR",$J,TYP,IEN)),U,2)
 ...S NSCR=$P($G(^TMP("LR",$J,TYP,IEN)),U,3)
 ..S NFX=$P($G(^TMP("LR",$J,TYP,IEN)),U,4)
 ..S ARY(TYP,CNT)=ANTIB_"|"_IEN_"|"_NFLDN_"|"_NINT_"|"_NSCR_"|"_NFX
 .I TYP="S6" D
 ..S CNT=CNT+1
 ..S ARY(TYP,CNT)=ANTIB_"|"_IEN
 ;
 Q
