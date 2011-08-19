PXRM7XT ;SLC/JVS HL7 EXTRACT FROM FILE; 06/01/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;This is the beginning of the extraction from the extract file
 ;
 ;VARIABLE LIST
 ;IEN = IEN OF ENTRY IN EXTRACT FILE 810.3
 Q
SPLIT ;SPLIT MESSAGES
 ;
 N ORC2
 I LINE>100 D
 .S ORCCNT=ORCCNT+1
 .D EN^PXRM7M1(.ID)
 .K ^TMP("HLS",$J)
 .S ORC2=$G(^TMP("PXRM7HLORC",$J))
 .S $P(ORC2,"|",3)="P"_ORCCNT,ORC=ORC2
 .S LINE=2
 .I $D(SEE) W !,ORC
 .S ^TMP("HLS",$J,1)=ORC
 Q
 ;
EXTRACT(IEN,SEE,ID,MODE) ;
 N ORCCNT
 K ERROR,LINE
 S ORCCNT=1  ;Count of ORC segments or number of messages created
 S LINE=1 ;Line count for the ^TMP("HL7",$J,LINE) global variable
 ;-Verify Values
 I '$D(^PXRMXT(810.3,IEN)) S ERROR(1)="No Such IEN in file 810.3 "_IEN
 I $D(ERROR) D  Q
 .I $D(SEE)=1
 ;-Extracting Value of Nodes in file
 I $D(ERROR) Q
 D GETS^DIQ(810.3,IEN,"**","EI","^TMP(""PXRM7"",$J)")
 D ORCSEG
 ;******Add NTE segment to end of message *******
 ;******change 3rd piece of ORC segement to L (last)****
 S NTE="NTE||"_LAST_"||"
 S ^TMP("HLS",$J,LINE)=NTE,LINE=LINE+1
 I SEE=1 W !,NTE
 K NTE,LAST
 S ORC=$G(^TMP("HLS",$J,1)),$P(ORC,"|",3)="F"_ORCCNT,^TMP("HLS",$J,1)=ORC
 ;***********************************************
 ;*******TURN ON BELOW TO TRANSMIT TO AUSTIN *****
 D EN^PXRM7M1(.ID)
 ;***********************************************
 K ^TMP("PXRM7",$J)
 K ^TMP("HLS",$J)
 K ^TMP("PXRM7HLORC",$J)
 ;********KILL LEFT OVER ARRAYS AND VARIABLES*****
 K HL("EID"),HLA("HLS"),PROTIEN,PXRM7,PXRM77,PXRM7ID,PXRM7R,ZMID
 K DA,DISYS,DISYS,EO,HL("EIDS"),HLECH,HLFS,HLN,HLQ,HLSAN,HLX
 K IENIEN,IENOBR,IENX,IENY,IENZ,L,LINE,NEXT,QTI,RFS,SEQ
 K STATION,USI
 ;**************************************************
 Q
ORCSEG ;CREATE ORC SEGMENTS
 ;ORDERED IN ORDER OF APPEARANCE IN SEGMENT
 ;QTI=QUANTITY AND TIMING
 ;EO=ENTERING ORGANIZATION
 ;--Below adds extra line feed in front of the message. --
 ;---------------------------------------------------
 S IENY=IEN_","
 ;---------------------------------------------
 ;0 PLACER ORDER NUMBER      ORC.2.1
 S $P(ORC,"|",3)="P1"
 ;---------------------------------------------
 ;1 REPORTING PERIOD         ORC.7.1.1
 S QTI(1)=$G(^TMP("PXRM7",$J,810.3,IENY,3,"E"))
 S $P(QTI,"~",1)=QTI(1)
 ;---------------------------------------------
 ;2 QUARTER                  ORC.7.3
 S QTI(3)=$G(^TMP("PXRM7",$J,810.3,IENY,7,"E"))
 S $P(QTI,"~",3)=QTI(3)
 ;---------------------------------------------
 ;3 BEGINNING DATE           ORC.7.4.1
 S QTI(4)=$$HLDATE^HLFNC($G(^TMP("PXRM7",$J,810.3,IENY,.02,"I")),"DT")
 S $P(QTI,"~",4)=QTI(4)
 ;---------------------------------------------
 ;4 ENDING DATE              ORC.7.5.1
 S QTI(5)=$$HLDATE^HLFNC($G(^TMP("PXRM7",$J,810.3,IENY,.03,"I")),"DT")
 S $P(QTI,"~",5)=QTI(5)
 ;---------------------------------------------
 ;5 REPORTING YEAR           ORC.7.11.2
 S QTI(11)="&"_$G(^TMP("PXRM7",$J,810.3,IENY,4,"E"))
 S $P(QTI,"~",11)=QTI(11)
 ;---------------------------------------------
 ;6 EXTRACT DATE             ORC.9.1
 S $P(ORC,"|",10)=$$HLDATE^HLFNC($G(^TMP("PXRM7",$J,810.3,IENY,.06,"I")),"DT")
 ;---------------------------------------------
 ;7 NAME                     ORC.17.2
 S EO(2)=$G(^TMP("PXRM7",$J,810.3,IENY,.01,"E"))
 S $P(EO,"~",2)=EO(2)
 ;---------------------------------------------
 ;8 REPORT EXTRACT PARAMETER ORC.17.5
 S EO(5)=$G(^TMP("PXRM7",$J,810.3,IENY,1,"E"))
 S $P(EO,"~",5)=EO(5)
 ;---------------------------------------------
 ;9 REPORT EXTRACT TYPE      ORC.18.2
 S $P(ORC,"|",19)="~"_$G(^TMP("PXRM7",$J,810.3,IENY,2,"E"))
 ;---------------------------------------------
 ;FINISH POPULATING ORC SEGMENT
 S $P(ORC,"|",8)=QTI
 S $P(ORC,"|",18)=EO
 S $P(ORC,"|",1)="ORC"
 ;---------------------------------------------
 ;SET HL7 TMP ARRAY AND SHOW SEGMENT
 S ^TMP("HLS",$J,LINE)=ORC,LINE=LINE+1
 I SEE=1 W !,ORC
 S ^TMP("PXRM7HLORC",$J)=ORC
 K ORC
OBRSEG ;CREATE OBR SEGMENTS
 ;N IENOBR,SEQ,USI,QTI,NEXT,STATION
 ;USI=UNIVERSAL SERVICE ID
 ;RFS=REASON FOR STUDY
 ;
 S NEXT=1,LAST=0
 S IENOBR=0 F  S IENOBR=$O(^PXRMXT(810.3,IEN,3,IENOBR)) Q:IENOBR<1  D
 .S IENIEN=-1 F  S IENIEN=$O(^PXRMXT(810.3,IEN,3,IENOBR,1,IENIEN)) Q:IENIEN="B"  D  Q:IENIEN=""
 ..S L=$S(IENIEN=0:1,IENIEN>0:2,IENIEN="":1,1:"")
 ..;###---Set Sequence Number
 ..S IENX=IENOBR_","_IEN_","
 ..S IENZ=IENIEN_","_IENOBR_","_IEN_","
 ..S SEQ=$G(^TMP("PXRM7",$J,810.33,IENX,.01,"E"))
 ..S OBR(+SEQ_L)="OBR|1|||||||||||||||||||||||||||||||"
 ..S $P(OBR(+SEQ_L),"|",2)=NEXT,LAST=NEXT,NEXT=NEXT+1
 ..;--------------------------------------------------
 ..;10 COUNT TYPE           OBR.4.2
 ..;R=REMINDER COUNTS  F=FINDING COUNTS
 ..S USI(2)=$S(L=1:"R",L=2:"F",1:"")
 ..S $P(USI,"~",2)=USI(2)
 ..;--------------------------------------------------
 ..;11 REMINDER             OBR.4.5
 ..S USI(5)=$G(^TMP("PXRM7",$J,810.33,IENX,.02,"E"))
 ..S $P(USI,"~",5)=USI(5)
 ..;--------------------------------------------------
 ..;12 STATION              OBR.3.1
 ..S STATION=$G(^TMP("PXRM7",$J,810.33,IENX,.03,"I"))_","
 ..D GETS^DIQ(4,STATION,"**","E","^TMP(""PXRM7"",$J)")
 ..S $P(OBR(+SEQ_L),"|",4)=$G(^TMP("PXRM7",$J,4,STATION,99,"E"))
 ..;--------------------------------------------------
 ..;13 PATIENT LIST         OBR.31.2
 ..S RFS(2)=$G(^TMP("PXRM7",$J,810.33,IENX,.04,"E"))
 ..S $P(RFS,"~",2)=RFS(2)
 ..;--------------------------------------------------
 ..;19 REMINDER TERM        OBR.31.1
 ..S RFS(1)=$S(L=2:$G(^TMP("PXRM7",$J,810.331,IENZ,.02,"E")),1:"")
 ..S $P(RFS,"~",1)=RFS(1)
 ..;--------------------------------------------------
 ..;20 FINDING TOTAL TYPE   OBR.31.4
 ..S RFS(4)=$S(L=2:$G(^TMP("PXRM7",$J,810.331,IENZ,.03,"E")),1:"")
 ..S $P(RFS,"~",4)=RFS(4)
 ..;--------------------------------------------------
 ..;21 GROUP NAME           OBR.31.5
 ..S RFS(5)=$S(L=2:$G(^TMP("PXRM7",$J,810.331,IENZ,.04,"E")),1:"")
 ..S $P(RFS,"~",5)=RFS(5)
 ..;--------------------------------------------------
 ..;22 REMINDER STATUS      OBR.4.4
 ..S USI(4)=$S(L=2:$G(^TMP("PXRM7",$J,810.331,IENZ,.05,"I")),1:"")
 ..S $P(USI,"~",4)=USI(4)
 ..;-------------------------------------------------
 ..;FINISH POPULATING OBR SEGMENT
 ..S $P(OBR(+SEQ_L),"|",5)=USI
 ..S $P(OBR(+SEQ_L),"|",32)=RFS
 ..;-------------------------------------------------
 ..;---Set message in HL7 array
 ..;I $L($G(OBR(+SEQ_L)))=255 S OBR(+SEQ_L)=OBR(+SEQ_L)_"|||" 
 ..S ^TMP("HLS",$J,LINE)=$G(OBR(+SEQ_L)),LINE=LINE+1
 ..;
 ..I SEE=1 W !," ",OBR(+SEQ_L)
 ..K OBR
 ..D OBXSEG
 ..D SPLIT
 ..I (L=1)&(IENIEN="") Q
 Q
OBXSEG ;CREATE THE OBX SEGMENTS
 N TERM
 ;OV=OBSERVATION VALUE
 S $P(OBX(+SEQ_L),"|",3)="MO"
 S $P(OBX(+SEQ_L),"|",1)="OBX"
 ;---------------------------------------------------
 ;###---SET SEQUENCE NUMBER
 S $P(OBX(+SEQ_L),"|",2)=1
 ;---------------------------------------------------
 ;14 TOTAL PATIENTS EVALUATED - REMINDER      OBX.5.1
 I L=1 D
 .S TERM="TOTAL PATIENTS EVALUATED"
 .S OV(1)=$G(^TMP("PXRM7",$J,810.33,IENX,2,"E"))_"~"_TERM
 .S $P(OV,"^",1)=OV(1)
 ;---------------------------------------------------
 ;15 TOTAL PATIENTS APPLICABLE - REMINDER     OBX.5.2
 I L=1 D
 .S TERM="TOTAL PATIENTS APPLICABLE"
 .S OV(2)=$G(^TMP("PXRM7",$J,810.33,IENX,3,"E"))_"~"_TERM
 .S $P(OV,"^",2)=OV(2)
 ;---------------------------------------------------
 ;16 TOTAL PATIENTS NOT APPLICABLE - REMINDER OBX.5.3
 I L=1 D
 .S TERM="TOTAL PATIENTS NOT APPLICABLE"
 .S OV(3)=$G(^TMP("PXRM7",$J,810.33,IENX,4,"E"))_"~"_TERM
 .S $P(OV,"^",3)=OV(3)
 ;---------------------------------------------------
 ;17 TOTAL PATIENTS DUE - REMINDER            OBX.5.4
 I L=1 D
 .S TERM="TOTAL PATIENTS DUE"
 .S OV(4)=$G(^TMP("PXRM7",$J,810.33,IENX,5,"E"))_"~"_TERM
 .S $P(OV,"^",4)=OV(4)
 ;---------------------------------------------------
 ;18 TOTAL PATIENTS NOT DUE - REMINDER        OBX.5.5
 I L=1 D
 .S TERM="TOTAL PATIENTS NOT DUE"
 .S OV(5)=$G(^TMP("PXRM7",$J,810.33,IENX,6,"E"))_"~"_TERM
 .S $P(OV,"^",5)=OV(5)
 ;---------------------------------------------------
 ;23 TOTAL COUNT - FINDING                    OBX.5.1
 I L=2 D
 .S TERM="TOTAL COUNT"
 .S OV(1)=$G(^TMP("PXRM7",$J,810.331,IENZ,1,"E"))_"~"_TERM
 .S $P(OV,"^",1)=OV(1)
 ;---------------------------------------------------
 ;24 APPLICABLE COUNT - FINDING               OBX.5.2
 I L=2 D
 .S TERM="APPLICABLE COUNT"
 .S OV(2)=$G(^TMP("PXRM7",$J,810.331,IENZ,2,"E"))_"~"_TERM
 .S $P(OV,"^",2)=OV(2)
 ;---------------------------------------------------
 ;25 NOT APPLICABLE COUNT- FINDING            OBX.5.3
 I L=2 D
 .S TERM="NOT APPLICABLE COUNT"
 .S OV(3)=$G(^TMP("PXRM7",$J,810.331,IENZ,3,"E"))_"~"_TERM
 .S $P(OV,"^",3)=OV(3)
 ;---------------------------------------------------
 ;26 DUE COUNT - FINDING                      OBX.5.4
 I L=2 D
 .S TERM="DUE COUNT"
 .S OV(4)=$G(^TMP("PXRM7",$J,810.331,IENZ,4,"E"))_"~"_TERM
 .S $P(OV,"^",4)=OV(4)
 ;---------------------------------------------------
 ;27 NOT DUE COUNT - FINDING                  OBX.5.5
 I L=2 D
 .S TERM="NOT DUE COUNT"
 .S OV(5)=$G(^TMP("PXRM7",$J,810.331,IENZ,5,"E"))_"~"_TERM
 .S $P(OV,"^",5)=OV(5)
 ;---------------------------------------------------
 ;FINISH POPULATING OBX SEGMENT
 S $P(OBX(+SEQ_L),"|",6)=OV
 K OV
 ;---------------------------------------------------
 ;###---Set message in HL7 array
 S ^TMP("HLS",$J,LINE)=$G(OBX(+SEQ_L)),LINE=LINE+1
 ;
 I SEE=1 W !,"   ",OBX(+SEQ_L)
 K OBX
 ;---------------------------------------------------
 Q
