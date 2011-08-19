RMPRHL7A ;HINES CIOFO/HNC - Receive HL-7 CPRS Message, parse into components and store in File 668 ;3/13/00
 ;;3.0;PROSTHETICS;**45,78,83**;Feb 09, 1996;Build 20
 ;
 ;Patch #78 - 09/25/03 - TH - Add multiple DG1 and ZCL segments.
 ;Patch #83 - 03/02/09 - DDA - Add check in OBR to screen out IFCs generated locally.
 ;
 Q
URG(X) ;Return Urgency give Z-code from HL-7 segment; see ORC+9
 S X=$S(X="S":"STAT",X="R":"ROUTINE",X="ZT":"TODAY",X="Z24":"WITHIN 24 HOURS",X="Z48":"WITHIN 48 HOURS",X="Z72":"WITHIN 72 HOURS",X="ZW":"WITHIN 1 WEEK",X="ZM":"WITHIN 1 MONTH",X="ZNA":"NEXT AVAILABLE",1:X)
 I $E(X,1)="Z" S X=$S(X="ZT":"TODAY",X="ZE":"EMERGENCY",1:"")
 Q X
 ;
ORC(RMPRORC) ;Get fields from ORC segment and set into RMPR variables
 S ^TMP("SPS","HL7",2)=RMPRORC
 ;RMPRTRLC=ORC control code from HL7 Table 119
 ;RMPRURGI=priority/urgency     RMPRPLCR=who entered the order
 ;RMPRORNP=provider             RMPRNATO=nature of order
 ;RMPRAD=date of request        RMPROCR=order request reason
 ;RMPR RMPRORFN=oe/rr file number
 ;RMPRO=file 668 IEN - if not a new order
 ;RMPRS38=order status - taken from Table 38, HL7 standard
 I $E(RMPRMSG,1,6)'="ORC|NW" S RMPRQT=1 Q
 S RMPRTRLC=$P(RMPRORC,"|",2)
 S RMPRORFN=$P(RMPRORC,"|",3)
 S RMPRORFN=$P($P(RMPRORFN,"^",1),";",1)
 S RMPRAPP=$P($P(RMPRORC,"|",3),"^",2)
 S RMPRS38=$P(RMPRORC,"|",6)
 S RMPRURGI=$P($P(RMPRORC,"|",8),"^",6)
 S RMPRPLCR=$P(RMPRORC,"|",11)
 S RMPRORNP=$P(RMPRORC,"|",13)
 I $L(RMPRURGI) S RMPRURGI=$$URG(RMPRURGI)
 S RMPRO=+$P($P(RMPRORC,"|",4),"^",1)
 N RMPRODT S RMPRODT=$P(RMPRORC,"|",16)
 S RMPRAD=$$FMDATE^RMPRHL7(RMPRODT)
 S RMPROCR=$P(RMPRORC,"|",17)
 S RMPRNATO=$P(RMPROCR,"^",5)
 Q
OBR(RMPROBR) ;Get fields from OBR segment and set into RMPR variables
 ;RMPRSS=type of consult, field 9, 1-4 if NO, then not prosthetics
 ;Must have 99CON in RMPR99C.
 ;
 ;RMPRODT=observation date/time
 ;RMPRPRI=procedure from file ^ORD(101,
 ;
 N RMPR99C
 S RMPR99C=$P($P(RMPROBR,"|",5),"^",6)
 I RMPR99C'="99CON" S RMPRSS="NO",RMPRQT=1 Q
 S RMPRSST=$P($P(RMPROBR,"|",5),"^",4)
 S RMPRSS=$P(^GMR(123.5,RMPRSST,0),U,1) D
 .;translate to set of codes
 .I RMPRSS["PROSTHETICS IFC" S RMPRSS="NO" Q
 .I RMPRSS["PROSTHETICS REQUEST" S RMPRSS=1 Q
 .I RMPRSS["CONTACT LENS REQUEST" S RMPRSS=3 Q
 .I RMPRSS["HOME OXYGEN REQUEST" S RMPRSS=4 Q
 .I RMPRSS["EYEGLASS REQUEST" S RMPRSS=2 Q
 .;then not prosthetics
 .S RMPRSS="NO"
 ;
 I RMPRSS="NO" S RMPRQT=1 Q
 ;
 S RMPRODT=$P(RMPROBR,"|",7)
 I RMPRODT]"" S RMPRODT=$$FMDATE^RMPRHL7(RMPRODT)
 S RMPRATN=$P(RMPROBR,"|",20)
 S RMPRSTDT=$P(RMPROBR,"|",23)
 S RMPRSTDT=$$FMDATE^RMPRHL7(RMPRSTDT)
 S RMPRS668=$P(RMPROBR,"|",26)
 S RMPRINTR=$P(RMPROBR,"|",33)
 Q
 ;
DG1(RMPRDG1) ;Get fields from DG1 and ZCL segments
 ; RMPRSID = Set ID
 ; RMPRDIAG = pointer to ICD DIAGNOSIS (#80)
 ; RMPRCI = Outpat. Classification Type
 ; RMPRVAL = Value of each SC or EI - 0,1,Null.
 S RMPRMSG=MSG(RMPRDG1)
 S RMPRSID=$P(RMPRMSG,"|",2)
 I $P(RMPRMSG,"|",1)="DG1" D
 . S RMPRDIAG=$P($P(RMPRMSG,"|",4),"^",1)
 . S RMPRMSG1(RMPRSID,1)=RMPRDIAG
 I $P(RMPRMSG,"|",1)="ZCL" D
 . S RMPRCI=$P(RMPRMSG,"|",3)
 . S RMPRVAL=$P(RMPRMSG,"|",4)
 . S RMPRMSG1(RMPRSID,RMPRCI+1)=RMPRVAL
 Q 
 ;
ZSV(RMPRZSV) ;Get service from ZSV segment
 S RMPRZSS=$P($P(RMPRZSV,"|",2),"^",4)
 ;Set the service if ZSV provided
 I $L($P(RMPRZSV,"|",3)) S RMPROTXT=$P(RMPRZSV,"|",3) ;consult type
 Q
 ;
OBX(RMPROBX) ;Get fields from OBX segment and set into RMPR variables
 ;RMPRVTYP=Value type from table 668-i.e. TX(text), ST(string data),etc.
 ;RMPROID=observation id identifying value in seg. 5
 ;RMPRVAL=observation value coded by segment 3
 ;RMPRPRDG=provisional diagnosis
 ;free text or code^free text^I9C
 S RMPRMSG=MSG(RMPROBX)
 S RMPRVTYP=$P(RMPRMSG,"|",3),RMPROID=$P($P(RMPRMSG,"|",4),"^",2)
 S RMPRVAL=$P(RMPROID,"^",3)
 I RMPROID="REASON FOR REQUEST" D
 .S RMPRRFQ(1)=$P(RMPRMSG,"|",6)
 .S LN=0 F  S LN=$O(MSG(RMPROBX,LN)) Q:LN=""  S RMPRRFQ(LN+1)=MSG(RMPROBX,LN)
 .Q
 I RMPROID="PROVISIONAL DIAGNOSIS" D  Q
 . I RMPRVTYP="TX" S RMPRPRDG=$P(RMPRMSG,"|",6) Q
 . I RMPRVTYP="CE" D  Q
 .. N PRDXSEG S PRDXSEG=$P(RMPRMSG,"|",6)
 .. S RMPRPRDG=$P(PRDXSEG,"^",2)_" ("_$P(PRDXSEG,"^")_")"
 .. S RMPRPRCD=$P(PRDXSEG,"^")
 I RMPROID["COMMENT" D
 .S RMPRCMT(1)=$P(RMPRMSG,"|",6)
 .S LN=0 F  S LN=$O(MSG(RMPROBX,NL)) Q:LN=""  S RMPRCMT(LN+1)=MSG(RMPROBX,LN)
 .Q
 K LN
 Q
 ;
EN(MSG) ;Entry point from protocol RMPR RECEIVE
 ;
 ;MSG = local array which contains the HL-7 segments
 ;RMPRFAC=sending facility
 ;RMPRMTP=message type
 N DFN,RMPRACT,RMPRADD,RMPRFAC,RMPRMTP,RMPRPNM,RMPRO,RMPROCR,RMPRORNP
 N RMPRORFN,RMPRPLCR,RMPRRB,RMPRSEND,RMPRSTS,RMPRTRLC,RMPRWARD,ORIFN
 N RMPRTRLC,RMPRAD,ORC,RMPRSBR,RMPRZSS,RMPRSS,RMPRSST,RMPROTXT
 N RMPRMSGO
 S RMPRMSG="",RMPRNOD=0,RMPRI=0
 F  S RMPRNOD=$O(MSG(RMPRNOD)) Q:RMPRNOD=""  S RMPRMSG=MSG(RMPRNOD) I $E(RMPRMSG,1,3)="MSH" D  Q
 .S RMPRSEND=$P(RMPRMSG,"|",3),RMPRFAC=$P(RMPRMSG,"|",4),RMPRMTP=$P(RMPRMSG,"|",9)
 .Q
 ;RMPRQT, stop flag in loop
 S RMPRMSG="",RMPRNOD=0,RMPRQT=0,N=0
 F  S RMPRNOD=$O(MSG(RMPRNOD)) Q:RMPRNOD=""  Q:RMPRQT=1  S RMPRMSG=MSG(RMPRNOD) D
 .I $E(RMPRMSG,1,3)="PID" D PID^RMPRHL7U(RMPRMSG) Q
 .I $E(RMPRMSG,1,3)="PV1" D PV1^RMPRHL7U(RMPRMSG) Q
 .;look at ORC|NW for new order
 .I $E(RMPRMSG,1,3)="ORC" D ORC(RMPRMSG) Q
 .I RMPRQT=1 Q
 .I $E(RMPRMSG,1,3)="OBR" D OBR(RMPRMSG) I RMPRSS="NO" S RMPRQT=1 K RMPRSS Q
 .I RMPRQT=1 Q
 .;Patch #78 - Add multiple DG1 and ZCL segments
 .I $E(RMPRMSG,1,3)="DG1"!($E(RMPRMSG,1,3)="ZCL") D DG1(RMPRNOD) Q
 .;look at ZSV for Prosthetic (4)
 .I $E(RMPRMSG,1,3)="ZSV" D ZSV(RMPRMSG) Q
 .I $E(RMPRMSG,1,3)="OBX" D OBX(RMPRNOD) Q
 .;I $E(RMPRMSG,1,3)="NTE" D NTE^RMPRHL7U(.MSG,RMPRNOD,RMPRO,RMPRTRLC) Q
 .Q
 K N
 ;check for new order, NW, and a prosthetic consult in RMPRSS
 I '$D(RMPRTRLC) D EXIT^RMPRHL7U Q
 I RMPRTRLC'="NW" D EXIT^RMPRHL7U Q
 I '$D(RMPRSS) D EXIT^RMPRHL7U Q
 I RMPRSS="NO" D EXIT^RMPRHL7U Q
 ;
 D NEW^RMPRHL7B
 ;
 I '$D(RMPRO) D REJECT^RMPRHL7U(.MSG,"unable to file order"),EXIT^RMPRHL7U Q
 ;
 D RTN(RMPRORFN,.RMPRO)
 ;
 D EXIT^RMPRHL7U
 Q
 ;
RTN(RMPRORN,RMPRO) ;Put ^OR(100, ien for order into ^RMPR(668, 
 S DA=RMPRO
 S DIE="^RMPR(668,",DR="19////^S X=RMPRORN"
 L +^RMPR(668,RMPRO) D ^DIE L -^RMPR(668,RMPRO)
 K DIE,DR
 ; set file 123 ien
 S RMPRGMRC=$$PKGID^ORX8($P(^RMPR(668,RMPRO,0),U,14))
 I RMPRGMRC["GMRC" S $P(^RMPR(668,RMPRO,0),U,15)=+RMPRGMRC
 E  D REJECT^RMPRHL7U(.MSG),EXIT^RMPRHL7U
 Q
