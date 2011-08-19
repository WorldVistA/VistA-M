DVBADD ;ALB/MLI - DD calls from AMIE files ; 2/15/96@1
 ;;2.7;AMIE;**4**;Apr 10, 1995
 ;
 ; This routine contains calls made from AMIE DDs
 ;
EXAMSET ; set logic for .01 field of AMIE EXAM file
 ; (loops through and resets APE x-refs in file 396.4)
 ;
 ; FM passes x=new value; da=ien
 ;
 ; uses I=loop counter,RD=request date,DFN=patient
 ;
 N I,DFN,NODE,NODE2,RD
 S I=0
 I $G(X)=""!($G(DA)="") Q
 I '$D(ZTQUEUED) W !,"Setting APE x-refs with new name...please wait"
 F  S I=$O(^DVB(396.4,"F",DA,I)) Q:'I  D
 . S NODE=$G(^DVB(396.4,I,0))
 . S NODE2=$G(^DVB(396.3,+$P(NODE,"^",2),0))
 . S DFN=+NODE2,RD=+$P(NODE2,"^",2)
 . S ^DVB(396.4,"APE",DFN,X,RD,I)=""
 Q
 ;
 ;
EXAMKILL ; kill logic for .01 field of AMIE EXAM file
 ; (loops through and kills APE x-refs in file 396.4)
 ;
 ; FM passes x=new value; da=ien
 ;
 ; uses I=loop counter,RD=request date,DFN=patient
 ;
 N I,DFN,NODE,NODE2,RD
 S I=0
 I $G(X)=""!($G(DA)="") Q
 I '$D(ZTQUEUED) W !,"Killing APE x-refs with old name...please wait"
 F  S I=$O(^DVB(396.4,"F",DA,I)) Q:'I  D
 . S NODE=$G(^DVB(396.4,I,0))
 . S NODE2=$G(^DVB(396.3,+$P(NODE,"^",2),0))
 . S DFN=+NODE2,RD=+$P(NODE2,"^",2)
 . K ^DVB(396.4,"APE",DFN,X,RD,I)
 Q
