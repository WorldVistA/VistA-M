IBDFBKS4 ;ALB/AAS - Create form spec file for scanning ; 6-JUN-95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**3,25**;APR 24, 1997
 ;
RECOMP ;Recompiles all form specs for paper keyboard
 N QZZ
 S QZZ=0 F  S QZZ=$O(^IBD(359.2,QZZ)) Q:'QZZ  D SCAN^IBDFBKS(QZZ)
 Q
 ;
FIELDS ;
 S FLD=1 F  S FLD=$O(@FIELDS@(PAGE,FLD)) Q:'FLD  D
 .N DATATP S DATATP=$G(@FIELDS@(PAGE,FLD,"DATATYPE"))
 .I DATATP="" D  Q
 ..S (LBEGIN,LEND,QUIT)=0
 ..S LBEGIN=FLD F  S FLD=$O(@FIELDS@(PAGE,FLD)) Q:QUIT  D  Q:QUIT
 ...I LEND=0,$S(FLD="":1,1:$G(@FIELDS@(PAGE,FLD,"DATATYPE"))'="") S FLD=LBEGIN D ONEBUB S QUIT=1 Q
 ...I FLD="",LEND>LBEGIN D LOOP(LBEGIN,LEND) S FLD=LEND,QUIT=1 Q
 ...I $G(@FIELDS@(PAGE,FLD,"DATATYPE"))'="" D LOOP(LBEGIN,LEND) S FLD=LEND,QUIT=1 Q
 ...S LEND=FLD
 ...Q
 .;
 .I DATATP'="" D
 ..N TOSTRING
 ..S TOSTRING=$S($G(@FIELDS@(PAGE,FLD,"START")):"narrative",1:"str")
 ..;
 ..D BLDARY^IBDFBKS(" "_TOSTRING_"=\""\"";")
 ..;
 ..I DATATP="ALPHA" D BLDARY^IBDFBKS(" if (GETSTATUS("_FLD_")==FIELD_OK) "_TOSTRING_"=STRIP(GETAVALUE("_FLD_"));") Q
 ..;
 ..I DATATP="FLOAT" D BLDARY^IBDFBKS(" if (GETSTATUS("_FLD_")==FIELD_OK) "_TOSTRING_"=STRIP(FTOA(GETFVALUE("_FLD_")));") Q
 ..;
 ..I DATATP="INT" D BLDARY^IBDFBKS(" if (GETSTATUS("_FLD_")==FIELD_OK) "_TOSTRING_"=STRIP(ITOA(GETIVALUE("_FLD_")));")  Q
 ..;
 ..I DATATP="DATE" D BLDARY^IBDFBKS(" if (GETSTATUS("_FLD_")==FIELD_OK) "_TOSTRING_"=STRIP(DTOA(GETIVALUE("_FLD_")));") Q
 ..;
 ..I DATATP="TIME" D BLDARY^IBDFBKS(" if (GETSTATUS("_FLD_")==FIELD_OK) "_TOSTRING_"=STRIP(TTOA(GETIVALUE("_FLD_")));") Q
 ..;
 ..;D BLDARY^IBDFBKS(" "_TOSTRING_"=STRFIELDS("_FLD_","_FLD_");") Q
 .;
 .I $G(@FIELDS@(PAGE,FLD,"MULT")),'$G(@FIELDS@(PAGE,FLD,"START")) D BLDARY^IBDFBKS(" if (str!=\""\"") narrative=STRIP(STRCAT(STRCAT(narrative,\"" \""),str));")
 .;
 .I '$G(@FIELDS@(PAGE,FLD,"MULT")) D
 ..D BLDARY^IBDFBKS(" if (str != \""\"") {")
 ..D BLDARY^IBDFBKS("   Data=Add;")
 ..I @FIELDS@(PAGE,FLD)'="" D BLDARY^IBDFBKS("   Data=STRCAT(Data,\"""_@FIELDS@(PAGE,FLD)_"\"");")
 ..D BLDARY^IBDFBKS("   Data=STRCAT(Data,str);")
 ..D BLDARY^IBDFBKS("   Data=STRCAT(Data,\"",\"");")
 ..D BLDARY^IBDFBKS("   if (ddechan != 0) result=DDEEXEC(ddechan,Data);}")
 ..D BLDARY^IBDFBKS("   ")
 .;
 .I $G(@FIELDS@(PAGE,FLD,"END")) D
 ..D BLDARY^IBDFBKS("    if (narrative!=\""\"") {")
 ..D BLDARY^IBDFBKS("   Data=Add;")
 ..I @FIELDS@(PAGE,FLD)'="" D BLDARY^IBDFBKS("   Data=STRCAT(Data,\"""_@FIELDS@(PAGE,FLD)_"\"");")
 ..D BLDARY^IBDFBKS("   Data=STRCAT(Data,narrative);")
 ..I $P($G(@FIELDS@(PAGE,FLD)),":")'="H" D BLDARY^IBDFBKS("   Data=STRCAT(Add,str);")
 ..D BLDARY^IBDFBKS("   Data=STRCAT(Data,\"",\"");")
 ..D BLDARY^IBDFBKS("   if (ddechan != 0) result=DDEEXEC(ddechan,Data);}")
FIELDSQ Q
 ;
ONEBUB ; -- for a single bubble field
 D BLDARY^IBDFBKS(" str=STRFIELDS("_FLD_","_FLD_");")
 D BLDARY^IBDFBKS(" if (str!=\""\"") {")
 I @FIELDS@(PAGE,FLD)'="" D BLDARY^IBDFBKS("   Data=STRCAT(Data,\"""_@FIELDS@(PAGE,FLD)_"\"");")
 D BLDARY^IBDFBKS("      Data=STRCAT(Add,str);")
 D BLDARY^IBDFBKS("      Data=STRCAT(Data,\"",\"");")
 D BLDARY^IBDFBKS("      if (ddechan != 0) result=DDEEXEC(ddechan,Data);}")
 Q
 ;
LOOP(LBEGIN,LEND) ; -- Loop through fields instead of one by one
 D BLDARY^IBDFBKS("  ")
 D BLDARY^IBDFBKS(" loop="_LBEGIN_";")
 D BLDARY^IBDFBKS(" while (loop < "_(LEND+1)_"){")
 D BLDARY^IBDFBKS("   str=STRFIELDS(loop,loop);")
 D BLDARY^IBDFBKS("   if (str!=\""\"") {")
 D BLDARY^IBDFBKS("      Data=STRCAT(Add,str);")
 D BLDARY^IBDFBKS("      Data=STRCAT(Data,\"",\"");")
 D BLDARY^IBDFBKS("      if (ddechan != 0) result=DDEEXEC(ddechan,Data);}")
 D BLDARY^IBDFBKS("   loop=loop+1;")
 D BLDARY^IBDFBKS(" if (loop > "_LEND_") break;}")
 D BLDARY^IBDFBKS("  ")
 Q
 ;
 ;;loop=9;
 ;;while (loop < 51){
 ;;    str=STRFIELDS(loop,loop);
 ;;    if (str!=\"\") {
 ;;      Data=STRCAT(Data,str);
 ;;      Data=STRCAT(Data,RS);}
 ;;   loop=loop+1;
 ;;   if (loop > 51) break;
 ;;   }
 ;;
 ;;\'SHOW(Data);
DATA1 ;;    Data = STRCAT(\"FORMTYPE=153\", RS);
 ;;    Data = STRCAT(Data, \"FORMID=\");
 ;;    Data = STRCAT(Data, ITOA(GETIVALUE(7)));
 ;;    Data = STRCAT(Data,RS);
 ;;    Data = STRCAT(Data,\"PAGE=1\");
 ;;    Data = STRCAT(Data,RS);
 ;;    Data = STRCAT(Data, \"DATA=\");
 ;;    Data = STRCAT(Data,RS);
 ;;
