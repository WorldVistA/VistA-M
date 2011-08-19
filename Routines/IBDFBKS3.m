IBDFBKS3 ;ALB/CJM/AAS - ENCOUNTER FORM - create form spec for scanning (Broker Version) ; 6-JUN-95 [ 11/13/96  3:32 PM ]
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
BUBBLE ;
 N COUNT
 ;
 D PRINTEND ;the end program for the prior field
 ;
 D BLDARY^IBDFBKS("FIELD ' "_FIELD)
 ;
 ;** NAME **
 D BLDARY^IBDFBKS("  NAME = """_NAME_""";")
 ;
 ;** ELEMTYPE **
 D BLDARY^IBDFBKS("  ELEMTYPE = RECT;")
 ;
 ;** METRIC **
 D BLDARY^IBDFBKS("  METRIC = 30 16 0 0 -16 -12 "_$G(IBDFILL,20)_" "_$G(IBDBKGND,5)_" 1;")
 ;D BLDARY^IBDFBKS("  METRIC = 30 16 0 0 -16 -12 20 5 1;")
 ;
 ;** DATATYPE **
 D BLDARY^IBDFBKS("  DATATYPE =INT;")
 ;
 ;** LENGTH **
 I (TYPE=1)!(TYPE=2) D
 .D BLDARY^IBDFBKS("  LENGTH = ")
 .S COUNT=0
 .S COL="" F  S COL=$O(@SCAN@(PAGE,FID,TYPE,COL)) Q:COL=""  S ROW="" F  S ROW=$O(@SCAN@(PAGE,FID,TYPE,COL,ROW)) Q:ROW=""  S COUNT=COUNT+1
 .S IBDFSA(IBLC)=IBDFSA(IBLC)_COUNT_";"
 I (TYPE=0)!(TYPE=3) D BLDARY^IBDFBKS("  LENGTH = 1;")
 ;
 ;** POINTS **
 I (TYPE=0)!(TYPE=3) S Y=ROW,X=COL D FINDBUB(.Y,.X) D BLDARY^IBDFBKS("  POINTS = "_Y_" "_X_";")
 I (TYPE=1)!(TYPE=2) D
 .D BLDARY^IBDFBKS("  POINTS =")
 .S COL="" F  S COL=$O(@SCAN@(PAGE,FID,TYPE,COL)) Q:COL=""  D
 ..S ROW="" F  S ROW=$O(@SCAN@(PAGE,FID,TYPE,COL,ROW)) Q:ROW=""  D
 ...S X=COL,Y=ROW
 ...D FINDBUB(.Y,.X)
 ...I $L(IBDFSA(IBLC))+$L(" "_Y_" "_X)<252 S IBDFSA(IBLC)=IBDFSA(IBLC)_" "_Y_" "_X Q
 ...D BLDARY^IBDFBKS("~~~"_" "_Y_" "_X)
 .S IBDFSA(IBLC)=IBDFSA(IBLC)_";"
 ;
 ;** PAGE **
 D BLDARY^IBDFBKS("  PAGE = "_PAGE_";")
 ;
 ;** END ** program to enforce selection rule and to go to end of page
 I TYPE=1 D  ;exactly one required
 .D ADDTOEND(" if (GETSTATUS("_FIELD_") == FIELD_BLANK){")
 .;D ADDTOEND("     \' SHOW(\"""_$$CKNAM(NAME)_" is required!\"");")
 .D ADDTOEND("    if (BATCH==0) {FIELDSTATUS = FIELD_BAD;}")
 .D ADDTOEND("    if (BATCH==1) {saveunrf = "_FIELD_";}")
 .D ADDTOEND("  }")
 .D ADDTOEND(" if ((GETSTATUS("_FIELD_") == FIELD_TOOMANY)&&(BATCH == 1)) {")
 .D ADDTOEND("    saveunrf = "_FIELD_";}")
 ;
 I TYPE=2 D  ;at most one required
 .D ADDTOEND(" if ((GETSTATUS("_FIELD_") == FIELD_TOOMANY)&&(BATCH == 1)) {")
 .D ADDTOEND("    saveunrf = "_FIELD_";}")
 ;
 I TYPE=3,LAST'="" D  ;at least one required
 .D ADDTOEND("    INT field;")
 .D ADDTOEND("    field="_FIRST_";") ;AAS Changed 11/14
 .N X S X=LAST+1 D ADDTOEND("    while (field<"_X_"){") ;AAS changed 11/14
 .D ADDTOEND("      if (GETSTATUS(field) != FIELD_BLANK) break;")
 .D ADDTOEND("      field=field+1;")
 .D ADDTOEND("    }")
 .S X=LAST+1 D ADDTOEND("    if (field == "_X_"){")
 .D ADDTOEND("      SHOW(\"""_$$CKNAM(OLDNAME)_" at least 1 required!\"");")
 .D ADDTOEND("      FIELDSTATUS = FIELD_BAD;")
 .D ADDTOEND("  }")
 ;D ADDTOEND("  };")
 ;
 ;** XMAP **
 ; -- only TYPE=0 (selection rule=anynumber) might be dynmaic
 I (TYPE=0)!(TYPE=3) D BLDARY^IBDFBKS("  XMAP = "","_$S($P(NODE,"^",9):"D:"_FID_":"_$P(NODE,"^",10),1:"B:"_IEN_":"_$$GETCODE($P(NODE,"^",2),$P(NODE,"^")))_""";")
 ;
 I (TYPE=1)!(TYPE=2) D
 .D BLDARY^IBDFBKS("  XMAP = """)
 .S COL=""
 .F  S COL=$O(@SCAN@(PAGE,FID,TYPE,COL)) Q:COL=""  D
 ..S ROW="" F  S ROW=$O(@SCAN@(PAGE,FID,TYPE,COL,ROW)) Q:ROW=""  D
 ...S IEN=$O(@SCAN@(PAGE,FID,TYPE,COL,ROW,0))  I IEN D
 ....S NODE=$G(^(IEN))
 ....N IBX
 ....S IBX=","_$S($P(NODE,"^",9):"D:"_FID_":"_$P(NODE,"^",10),1:"B:"_IEN_":"_$$GETCODE($P(NODE,"^",2),$P(NODE,"^")))
 ....I $L(IBDFSA(IBLC))+$L(IBX)<252 S IBDFSA(IBLC)=IBDFSA(IBLC)_IBX Q
 ....D BLDARY^IBDFBKS("~~~"_IBX)
 .S IBDFSA(IBLC)=IBDFSA(IBLC)_""";"
 ;
 ;** MAP **
 I (TYPE=0)!(TYPE=3) D BLDARY^IBDFBKS("  MAP = "" ,"_$TR($P(NODE,"^",6),",;"," ")_""";")
 ;
 I (TYPE=1)!(TYPE=2) D
 .D BLDARY^IBDFBKS("  MAP = "" ")
 .;
 .S COL="" F  S COL=$O(@SCAN@(PAGE,FID,TYPE,COL)) Q:COL=""  S ROW="" F  S ROW=$O(@SCAN@(PAGE,FID,TYPE,COL,ROW)) Q:ROW=""  S IEN=$O(@SCAN@(PAGE,FID,TYPE,COL,ROW,0)) D
 ..I IEN S NODE=$G(@SCAN@(PAGE,FID,TYPE,COL,ROW,IEN))
 ..I $L(IBDFSA(IBLC))+$L($TR($P(NODE,"^",6),",;"," "))<252 S IBDFSA(IBLC)=IBDFSA(IBLC)_","_$TR($P(NODE,"^",6),",;"," ") Q
 ..D BLDARY^IBDFBKS("~~~"_","_$TR($P(NODE,"^",6),",;"," "))
 .S IBDFSA(IBLC)=IBDFSA(IBLC)_""";"
 I $D(OTHER($P(FID,"("),IEN)) S OTHER($P(FID,"("),IEN)=FIELD
 Q
 ;
FINDBUB(Y,X) ;
 ;converts row,col of bubble to paperkeyboard points, with proper offsets added - call by reference
 S X=((COL*COLWIDTH)+(XBUBOS+XOFFSET))*CONVERT
 ;S X=1+$FN(X,"",0)
 S X=$FN(X,"",0)
 S Y=((ROW*ROWHT)+(YOFFSET+YBUBOS))*CONVERT
 ;S Y=1+$FN(Y,"",0)
 S Y=$FN(Y,"",0)
 Q
 ;
ADDTOBEG(TEXT) ;
 I '$D(BEGIN) S BEGIN(1)="   BEGIN = {",BLN=1
 S BLN=BLN+1
 S BEGIN(BLN)=TEXT
 Q
 ;
PRINTBEG ;
 I $D(BEGIN) D
 .S BLN=0 F  S BLN=$O(BEGIN(BLN)) Q:'BLN  D BLDARY^IBDFBKS(BEGIN(BLN))
 .D BLDARY^IBDFBKS("   };")
 .K BEGIN
 Q
 ;
ADDTOEND(TEXT) ;
 I '$D(END) S END(1)="  END = {",LN=1
 S LN=LN+1
 S END(LN)=TEXT
 Q
 ;
PRINTEND ;
 I $D(END) D
 .S LN=0 F  S LN=$O(END(LN)) Q:'LN  D BLDARY^IBDFBKS(END(LN))
 .D BLDARY^IBDFBKS("  };")
 .K END
 I PRIORPG'=PAGE D PAGEEND(PRIORPG)
 I PAGE>1,PRIORPG'=PAGE D PAGETOP(PAGE)
 S PRIORPG=PAGE
 Q
 ;
GETCODE(VALUE,PI) ;returns the value after passing it through the output transform contained in the package interface file
 ;
 N X,Y S (Y,X)=VALUE
 ;
 I PI X $G(^IBE(357.6,PI,14))
 Q Y
 ;
PAGEEND(PAGE) ;end of page processing
 N FLD
 S FIELD=FIELD+1
 F COUNT=1:1 S LINE=$T(BOTTOM+COUNT^IBDFBKS1),TAG=$P(LINE,";;"),LINE=$P(LINE,";;",2) Q:TAG["QUIT"  D
 .I TAG["NUMBER" D BLDARY^IBDFBKS("FIELD ' "_FIELD) Q
 .I TAG["NAME" D BLDARY^IBDFBKS("  NAME = ""BOTTOM OF PAGE"_PAGE_""";") Q
 .I TAG["PAGE" D BLDARY^IBDFBKS("  PAGE = "_PAGE_";") Q
 .I TAG["SAVE" D  Q
 ..D BLDARY^IBDFBKS("  Save = STRCAT(\""SAVEFORM(\"",ITOA(GETIVALUE(7)));")
 ..D BLDARY^IBDFBKS("  Save = STRCAT(Save,"","_PAGE_",,V)"");")
 ..;
 .I TAG["EXPORT" D  Q
 ..D BLDARY^IBDFBKS("   DDEEXEC(ddechan,\""$$NEW$$("");")
 ..D BLDARY^IBDFBKS("   Data=\""$$ADD$$(FORMTYPE="_IBFORMID_",\"";")
 ..D BLDARY^IBDFBKS("   DDEEXEC(ddechan,Data);")
 ..D BLDARY^IBDFBKS("   Data=STRCAT(\""$$ADD$$(FORMID=\"",ITOA(GETIVALUE(7)));")
 ..D BLDARY^IBDFBKS("   Data=STRCAT(Data,\"",\"");")
 ..D BLDARY^IBDFBKS("   DDEEXEC(ddechan,Data);")
 ..D BLDARY^IBDFBKS("   Data=\""$$ADD$$(PAGE="_PAGE_",\"";")
 ..D BLDARY^IBDFBKS("   DDEEXEC(ddechan,Data);")
 ..D BLDARY^IBDFBKS("   Data=\""$$ADD$$(DATA=,\"";")
 ..D BLDARY^IBDFBKS("   DDEEXEC(ddechan,Data);")
 ..;
 ..D FIELDS^IBDFBKS4
 .D BLDARY^IBDFBKS(LINE)
 Q
 ;
 ;;;.I TAG["EXPORT" D  Q
 ;;;D BLDARY^IBDFBKS("   Data=STRCAT(\""FORMTYPE="_IBFORMID_"\"",RS);")
 ;;;D BLDARY^IBDFBKS("   Data=STRCAT(Data,\""FORMID=\"");")
 ;;;D BLDARY^IBDFBKS("   Data=STRCAT(Data,ITOA(GETIVALUE(7)));")
 ;;;D BLDARY^IBDFBKS("   Data=STRCAT(Data,RS);")
 ;;;D BLDARY^IBDFBKS("   Data=STRCAT(Data,\""PAGE="_PAGE_"\"");")
 ;;;D BLDARY^IBDFBKS("   Data=STRCAT(Data,RS);")
 ;;;D BLDARY^IBDFBKS("   Data=STRCAT(Data,\""DATA=\"");")
 ;;;D BLDARY^IBDFBKS("   Data=STRCAT(Data,RS);")
 ;;;..D BLDARY^IBDFBKS("   DDEEXEC(ddechan,Data);")
 ;
PAGETOP(PAGE) ;add field for top of page
 S FIELD=FIELD+1
 F COUNT=1:1 S LINE=$T(TOPOFPG+COUNT^IBDFBKS1),TAG=$P(LINE,";;"),LINE=$P(LINE,";;",2) Q:TAG["QUIT"  D
 .I TAG["NUMBER" D BLDARY^IBDFBKS("FIELD ' "_FIELD) Q
 .I TAG["FLDNAME" D BLDARY^IBDFBKS("  NAME = ""TOP OF PAGE "_PAGE_""";") Q
 .I TAG["PAGE" D BLDARY^IBDFBKS("  PAGE = "_PAGE_";") Q
 .D BLDARY^IBDFBKS(LINE)
 Q
CKNAM(NAME) ;  - format name with \ for paperkey when displaying name
 F CHAR="\","'" I NAME[CHAR D
 .F A=1:1:$L(NAME,CHAR)-1 S NAME=$P(NAME,CHAR,1,A)_"\"_CHAR_$P(NAME,CHAR,A+1,$L(NAME,CHAR))
 Q NAME
