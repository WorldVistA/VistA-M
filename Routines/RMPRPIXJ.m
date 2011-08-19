RMPRPIXJ ;HIN/RVD - INVENTORY UTILITY UPDATE BALANCE ;2/13/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 W !,"***Invalid Entry!!!!" Q
 ;
SVAL(RX) ;STARTING total Value.
 ;The Starting total Value is the Total Value of the previous entry
 ;date specified.  If no previous entry, the Total Value will 
 ;be set to ZERO.
 ;
 ;pass variable station, hcpcs, hcpcs item and date in RX local array.
 ; RX("STA") = station
 ; RX("HCP") = HCPCS
 ; RX("ITE") = HCPCS item
 ; RX("RDT") = date (starting date)
 ; REBAL = return variable (Starting Total Value based on the date)
 N X,Y,RS,RH,RM,RD,RI,RQ,RC,RMERR,RMERROR,RMDAT,RDATA,RDATE,REBAL
 S REBAL=0
 S RS=RX("STA"),RH=RX("HCP"),RM=RX("ITE"),RD=RX("RDT")
 Q:(RS="")!(RH="")!(RM="")!(RD="") REBAL
 S RDATE=$O(^RMPR(661.9,"ASHID",RS,RH,RM,RD),-1)
 I '$G(RDATE) Q REBAL
 S RI=$O(^RMPR(661.9,"ASHID",RS,RH,RM,RDATE,0))
 S RDATA=$G(^RMPR(661.9,RI,0))
 S REBAL=$P(RDATA,U,9)
 Q REBAL
 ;
 ;
CVAL(RX) ;CURRENT total Value
 ;The Current total Value is the total value based on the date specified.
 ;If the Date specified has no entry, the Current Total Value will be
 ;extracted from the previous date entry.  If it has no previous entry,
 ;the Current Total Value will be set to ZERO.
 ; 
 ;pass variable station, hcpcs, hcpcs item and date in RX local array.
 ; RX("STA") = station
 ; RX("HCP") = HCPCS
 ; RX("ITE") = HCPCS item
 ; RX("RDT") = date (current date)
 ; REBAL = return variable (Current Total value based on the date)
 N X,Y,RS,RH,RM,RD,RI,RQ,RC,RMERR,RMERROR,RMDAT,RDATA,RDATE,REBAL
 S REBAL=0
 S RS=RX("STA"),RH=RX("HCP"),RM=RX("ITE"),RD=RX("RDT")
 Q:(RS="")!(RH="")!(RM="")!(RD="") REBAL
 S RI=$O(^RMPR(661.9,"ASHID",RS,RH,RM,RD,0))
 I '$G(RI) D  I '$G(RI) Q REBAL
 .S RDATE=$O(^RMPR(661.9,"ASHID",RS,RH,RM,RD),-1)
 .S:$G(RDATE) RI=$O(^RMPR(661.9,"ASHID",RS,RH,RM,RDATE,0))
 S RDATA=$G(^RMPR(661.9,RI,0))
 S REBAL=$P(RDATA,U,9)
 Q REBAL
 ;
 ;
SQTY(RX) ;STARTING total Quantity.
 ;The Starting total Quantity is the Total qty of the previous entry
 ;date specified.  If no previous entry, the Total qty will 
 ;be set to ZERO.
 ;
 ;pass variable station, hcpcs, hcpcs item and date in RX local array.
 ; RX("STA") = station
 ; RX("HCP") = HCPCS
 ; RX("ITE") = HCPCS item
 ; RX("RDT") = date (starting date)
 ; REBAL = return variable (Starting Total qty based on the date)
 N X,Y,RS,RH,RM,RD,RI,RQ,RC,RMERR,RMERROR,RMDAT,RDATA,RDATE,REBAL
 S REBAL=0
 S RS=RX("STA"),RH=RX("HCP"),RM=RX("ITE"),RD=RX("RDT")
 Q:(RS="")!(RH="")!(RM="")!(RD="") REBAL
 S RDATE=$O(^RMPR(661.9,"ASHID",RS,RH,RM,RD),-1)
 I '$G(RDATE) Q REBAL
 S RI=$O(^RMPR(661.9,"ASHID",RS,RH,RM,RDATE,0))
 S RDATA=$G(^RMPR(661.9,RI,0))
 S REBAL=$P(RDATA,U,8)
 Q REBAL
 ;
 ;
CQTY(RX) ;CURRENT total QTY
 ;The Current total qty is the total qty based on the date specified.
 ;If the Date specified has no entry, the Current Total qty will be
 ;extracted from the previous date entry.  If it has no previous entry,
 ;the Current Total qty will be set to ZERO.
 ;
 ;pass variable station, hcpcs, hcpcs item and date in RX local array.
 ; RX("STA") = station
 ; RX("HCP") = HCPCS
 ; RX("ITE") = HCPCS item
 ; RX("RDT") = date (current date)
 ; REBAL = return variable (Current Total qty based on the date)
 N X,Y,RS,RH,RM,RD,RI,RQ,RC,RMERR,RMERROR,RMDAT,RDATA,RDATE,REBAL
 S RS=RX("STA"),RH=RX("HCP"),RM=RX("ITE"),RD=RX("RDT")
 Q:(RS="")!(RH="")!(RM="")!(RD="") REBAL
 S RI=$O(^RMPR(661.9,"ASHID",RS,RH,RM,RD,0))
 I '$G(RI) D  I '$G(RI) Q REBAL
 .S RDATE=$O(^RMPR(661.9,"ASHID",RS,RH,RM,RD),-1)
 .S:$G(RDATE) RI=$O(^RMPR(661.9,"ASHID",RS,RH,RM,RDATE,0))
 S RDATA=$G(^RMPR(661.9,RI,0))
 S REBAL=$P(RDATA,U,8)
 Q REBAL
 ;
TVAQT ;get total qty and cost from 661.7
 N R7I,R7J,R7DAT,R7QBAL,R7CBAL
 S (RMPRQBAL,RMPRCBAL)=0
 F R7I=0:0 S R7I=$O(^RMPR(661.7,"XSHIDS",RS,RH,RM,R7I)) Q:R7I'>0  F R7J=0:0 S R7J=$O(^RMPR(661.7,"XSHIDS",RS,RH,RM,R7I,1,R7J)) Q:R7J'>0  D
 .S R7DAT=$G(^RMPR(661.7,R7J,0))
 .S R7QBAL=$P(R7DAT,U,7)
 .S R7CBAL=$P(R7DAT,U,8)
 .I $G(R7QBAL) S RMPRQBAL=RMPRQBAL+R7QBAL
 .I $G(R7CBAL) S RMPRCBAL=RMPRCBAL+R7CBAL
 Q
 ;
UPCR(RX) ;UPDATE or CREATE entry in 661.9
 ;If an entry already exist, this subroutine will update the entry.
 ;If no entry exist, this subroutine will create an entry.
 ;The calling routine should check if $G(RMERROR), then error occured.
 ;
 ;pass variable station, hcpcs, hcpcs item, date, total quantity
 ;and total cost in RX local array.
 ; RX("STA") = station
 ; RX("HCP") = HCPCS
 ; RX("ITE") = HCPCS item
 ; RX("RDT") = date
 ; RX("TQTY")= net quantity to add to balance
 ; RX("TCST")= net cost to add to balance
 N X,Y,RS,RH,RM,RD,RI,RQ,RC,RMERR,RMERROR,RMDAT,RDATA,RDATE,REBAL
 N RMPRCBAL,RMPRQBAL
 S RMERROR=0
 S RS=RX("STA"),RH=RX("HCP"),RM=RX("ITE"),RD=RX("RDT")
 S RQ=RX("TQTY"),RC=$J(RX("TCST"),0,2)
 I (RS="")!(RH="")!(RD="") S RMERROR=1 Q RMERROR
 S (RMPRQBAL,RMPRCBAL)="" ;init quantity and cost balances
 L +^RMPR(661.9,"ASHID",RS,RH,RM)
UPCRA K RI,RMDAT,RMERR,RDATA
 ;get the current total quntity and cost from 661.7.
 D TVAQT
 S RI=$O(^RMPR(661.9,"ASHID",RS,RH,RM,RD,0))
 ;if there is an entry, update totals: (balance & cost).
 I $G(RI) D
 .S RDATA=$G(^RMPR(661.9,RI,0))
 .;S RMPRQBAL=$P(RDATA,U,8)
 .;S RMPRCBAL=$P(RDATA,U,9)
 .S RMDAT(661.9,RI_",",.01)=RD
 .S RMDAT(661.9,RI_",",1)=RH
 .S RMDAT(661.9,RI_",",2)=RM
 .S RMDAT(661.9,RI_",",4)=RS
 .S RMDAT(661.9,RI_",",7)=RMPRQBAL
 .S RMDAT(661.9,RI_",",8)=RMPRCBAL
 .D FILE^DIE("K","RMDAT","RMERR")
 .I $D(RMERR) S RMERROR=1
 ;if no entry, create an entry for the date being passed.
 E  D
 .S RX("RDT")=RD
 .S RMDAT(661.9,"+1,",.01)=RD
 .S RMDAT(661.9,"+1,",1)=RH
 .S RMDAT(661.9,"+1,",2)=RM
 .S RMDAT(661.9,"+1,",4)=RS
 .S RMDAT(661.9,"+1,",7)=RMPRQBAL
 .S RMDAT(661.9,"+1,",8)=RMPRCBAL
 .D UPDATE^DIE("","RMDAT","RI","RMERR")
 .I $D(RMERR) S RMERROR=1
 I RMERROR G UPCRU
 ;
 ; Get next date and continue update so that all subsequent
 ; balances are correct
UPCRN S RD=$O(^RMPR(661.9,"ASHID",RS,RH,RM,RD))
 I RD'="" G UPCRA
UPCRU L -^RMPR(661.9,"ASHID",RS,RH,RM)
UPCRX Q RMERROR
 ;
ALLREC(RMA) ;reconcile all HCPCS in 661.9
 Q:RMA'="TEST"
 N RM11,RM11DAT,RX
 S U="^",RMERR=0
 S RX("TQTY")=0
 S RX("TCST")=0
 S RX("RDT")=DT
 F RM11=0:0 S RM11=$O(^RMPR(661.11,RM11)) Q:RM11'>0  D
 .S RM11DAT=^RMPR(661.11,RM11,0)
 .S RX("HCP")=$P(RM11DAT,U,1)
 .S RX("ITE")=$P(RM11DAT,U,2)
 .S RX("STA")=$P(RM11DAT,U,4)
 .W !,RX("HCP"),"  ",RX("ITE")," ",RX("STA")
 .S RMERR=$$UPCR^RMPRPIXJ(.RX)
 Q RMERR
 ;
NVAR ;new all variables
 N X,Y,RS,RH,RM,RD,RI,RQ,RC,RMERR,RMERROR,RMDAT,RDATA,RDATE,REBAL
 N RMPRCBAL,RMPRQBAL
 Q
