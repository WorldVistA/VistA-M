KMPDTU01 ;OAK/RAK - CM Tools Timing Utility ;4/6/06  08:40
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**4,5**;Mar 22, 2002
 ;
DAILY(KMPDT) ;-- transmit daily stats to national database
 ;-----------------------------------------------------------------------
 ; KMPDT.... Compression date in internal fileman formt. It represents 
 ;           the date from which the previous days data should be
 ;           transmitted. 
 ;           Example: if KMPDT = 2981011  then tranmission will be
 ;                    on 2981010 (KMPDT-1)
 ;-----------------------------------------------------------------------
 ;
 Q:'$G(KMPDT)
 ;
 N DATE,DATA,DELTA,ERROR,FDA,HOUR,I,IEN,PIECE,PTNP,SDTM,SITE,SS
 N STR
 ;
 ; storage  processed
 K ^TMP($J),^TMP("KMPDTU01",$J)
 ; site info.
 S SITE=$$SITE^VASITE Q:SITE=""
 S IEN=0
 W:'$D(ZTQUEUED) !,"Compressing data into daily format..."
 F  S IEN=$O(^KMPD(8973.2,"ADT",KMPDT,IEN)) Q:'IEN  D 
 .Q:'$D(^KMPD(8973.2,IEN,0))  S DATA(0)=^(0)
 .; quit if daily data has already been sent to national database
 .;Q:$P(DATA(0),U,10)
 .W:'$D(ZTQUEUED)&('(IEN#1000)) "."
 .; start date/time      date w/no time    delta
 .S SDTM=$P(DATA(0),U,3),DATE=$P(SDTM,"."),DELTA=$P(DATA(0),U,4)
 .; hour
 .S HOUR=+$E($P(SDTM,".",2),1,2)
 .; quit if no kmptmp subscript
 .S SS=$P(DATA(0),U,7)  Q:SS=""
 .;
 .S PTNP=$$PTNP^KMPDHU03(SDTM) Q:'PTNP
 .; piece 4 - prime time
 .; piece 5 - non-prime time
 .S PIECE=$S(PTNP=1:4,1:5)
 .;
 .S $P(^TMP($J,KMPDT,SS),U)=KMPDT
 .S $P(^TMP($J,KMPDT,SS),U,3)=SS
 .S $P(^TMP($J,KMPDT,SS),U,PIECE)=$P(^TMP($J,KMPDT,SS),U,PIECE)+DELTA
 .S $P(^TMP($J,KMPDT,SS),U,(PIECE+2))=$P(^TMP($J,KMPDT,SS),U,(PIECE+2))+1
 .; hourly delta
 .S $P(^TMP($J,KMPDT,SS,PTNP),U,(HOUR+1))=$P($G(^TMP($J,KMPDT,SS,PTNP)),U,(HOUR+1))+DELTA
 .; hourly occurrences
 .S $P(^TMP($J,KMPDT,SS,PTNP+.1),U,(HOUR+1))=$P($G(^TMP($J,KMPDT,SS,PTNP+.1)),U,(HOUR+1))+1
 .; node 99.1 is for national database (end date^facility name)
 .S ^TMP($J,KMPDT,SS,99.1)=KMPDT_"^"_$P(SITE,U,2)_"^"_$P(SITE,U,3)_"^"_$$WORKDAY^XUWORKDY(DATE)
 .; add to processed array.
 .S ^TMP("KMPDTU01",$J,IEN)=""
 ;
 D:$D(^TMP($J)) TRANSMIT(2)
 K ^TMP($J)
 ;
 ; update field .1 (DAILY - SENT TO CM NATIONAL DB) to 'YES' for all
 ; processed entries.
 W:'$D(ZTQUEUED) !!,"Updating records to reflect transmission..."
 S IEN=0
 F  S IEN=$O(^TMP("KMPDTU01",$J,IEN)) Q:'IEN  D 
 .K FDA,ERROR W:'$D(ZTQUEUED)&('(IEN#1000)) "."
 .S FDA($J,8973.2,IEN_",",.1)=1
 .D FILE^DIE("","FDA($J)","ERROR")
 ;
 K ^TMP("KMPDTU01",$J)
 ;
 W:'$D(ZTQUEUED) !!,"Finished!"
 ;
 Q
 ;
TRANSMIT(KMPDTWD) ;-- format data into e-mail and send to cm national database
 ;-----------------------------------------------------------------------
 ; KMPDTWD... Weekly/Daily
 ;             1 - weekly
 ;             2 - daily
 ;
 ; D = date
 ; S = subscript
 ;-----------------------------------------------------------------------
 ;
 Q:'$G(KMPDTWD)
 Q:'$D(^TMP($J))
 ;
 N CPU,D,DATE,I,IEN,LN,S,TL,TRANSTO,XMSUB,X,XMTEXT,XMY,XMZ,Y,Z
 ;
 K ^TMP("KMPDTU01-2",$J)
 ;
 S DATE=$S(KMPDTWD=1:$G(START),1:$G(KMPDT))
 S LN=0
 ; version and patch info
 S LN=LN+1,^TMP("KMPDTU01-2",$J,LN)="VERSION="_$$VERSION^KMPDUTL
 ; system information
 S LN=LN+1,^TMP("KMPDTU01-2",$J,LN)="SYSINFO="_$$SYSINFO^KMPDUTL1()
 ; send cpu data to national database
 D CPU^KMPDUTL5(.CPU) I $D(CPU) S I="" F  S I=$O(CPU(I)) Q:I=""  D 
 .S LN=LN+1,^TMP("KMPDTU01-2",$J,LN)="CPU="_I_U_CPU(I)
 ;
 W:'$D(ZTQUEUED) !!,"Formatting ",$$FMTE^XLFDT($G(START))," data for mail delivery..."
 ; reformat so that data is in ^TMP("KMPR UPLOAD",$J,LN)= format.
 S IEN=0,D=""
 F  S D=$O(^TMP($J,D)) Q:D=""  S S="" W "." D 
 .W !,D
 .F  S S=$O(^TMP($J,D,S)) Q:S=""  D 
 ..S IEN=IEN+1,LN=LN+1
 ..S ^TMP("KMPDTU01-2",$J,LN)=IEN_",0)="_^TMP($J,D,S)
 ..; if prime time
 ..I $D(^TMP($J,D,S,1)) D 
 ...S LN=LN+1
 ...S ^TMP("KMPDTU01-2",$J,LN)=IEN_",1)="_^TMP($J,D,S,1)
 ...S LN=LN+1
 ...S ^TMP("KMPDTU01-2",$J,LN)=IEN_",1.1)="_^TMP($J,D,S,1.1)
 ..; if non-prime time
 ..I $D(^TMP($J,D,S,2)) D 
 ...S LN=LN+1
 ...S ^TMP("KMPDTU01-2",$J,LN)=IEN_",2)="_^TMP($J,D,S,2)
 ...S LN=LN+1
 ...S ^TMP("KMPDTU01-2",$J,LN)=IEN_",2.1)="_^TMP($J,D,S,2.1)
 ..; node 99.1 for national database
 ..S LN=LN+1,^TMP("KMPDTU01-2",$J,LN)=IEN_",99.1)="_$G(^TMP($J,D,S,99.1))
 ;
 ; quit if no data to transmit.
 Q:'$D(^TMP("KMPDTU01-2",$J))
 S TL=$$TESTLAB^KMPDUT1
 ; send packman message.
 S XMTEXT="^TMP(""KMPDTU01-2"","_$J_","
 S XMSUB=$S(KMPDTWD=1:"CM TIMING DATA~",1:"CM TIMING DATA-DAILY~")_$P(TL,U,2)_$P(SITE,U,2)_" ("_$P(SITE,U,3)_")~"_$$FMTE^XLFDT(DATE,2)
 D TRANSTO^KMPDUTL7(1,4,.TRANSTO) Q:'$D(TRANSTO)
 S I=""
 F  S I=$O(TRANSTO(I)) Q:I=""  S XMY(I)=""
 D ^XMD
 W:'$D(ZTQUEUED) !,"Message #",$G(XMZ)," sent..."
 K ^TMP("KMPDTU01-2",$J)
 ;
 Q
