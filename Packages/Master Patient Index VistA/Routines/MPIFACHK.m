MPIFACHK ;CMC/BP-ACKNOWLEDGEMENT CHECK ;JULY 8, 2002
 ;;1.0; MASTER PATIENT INDEX VISTA ;**22**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;   START, STOP, EXC^RGHLLOG - #2796
 ;
EN(RETURN,BEFORE) ; CHECKING FOR "A" FOR XTMP("MPIFA.. NODES that happened before FM date BEFORE
 ;RPC - RETURN will have 0 if no messages need to be resent OR 1 if there are some resent.
 ;
 N DFN2,TAG,MPIFHL,ICN,ICN2 K MPIFMSG
 M MPIFHL=HL ;need to save hl variables to avoid undefined errors when returning to RPC.
 S MPIFMSG="MPIFA",RETURN=0
 F  S MPIFMSG=$O(^XTMP(MPIFMSG)) Q:$E(MPIFMSG,1,5)'="MPIFA"  D
 .Q:$P(^XTMP(MPIFMSG,0),"^",2)>BEFORE
 .I $E(MPIFMSG,1,7)="MPIFA40" D
 ..S DFN2=$O(^XTMP(MPIFMSG,0))
 ..Q:DFN2=""
 ..I $G(^XTMP(MPIFMSG,DFN2,"MPI",0))="A" D
 ...S ICN=$G(^XTMP(MPIFMSG,DFN2,"MPI",1))
 ...S ICN2=$P(ICN,"^",2),MSGN=$P(ICN,"^",3),ICN=$P(ICN,"^")
 ...S RETURN=1
 ...D START^RGHLLOG()
 ...D EXC^RGHLLOG(208,"Merge msg A40 for TO record ICN1= "_ICN_" FROM record ICN2= "_ICN2_". HL7 msg id= "_MSGN_" No ACK received back")
 ...D STOP^RGHLLOG()
 ..K ^XTMP(MPIFMSG)
 .Q:MPIFMSG["A40"
 .Q:'$D(^XTMP(MPIFMSG,"MPI",0))
 .I $G(^XTMP(MPIFMSG,"MPI",0))="A" D
 ..S TAG=$E(MPIFMSG,5,7)
 ..D @TAG S RETURN=1
 K MPIFMSG
 M HL=MPIFHL
 ;
 S MPIFMSG="RGA"
 F  S MPIFMSG=$O(^XTMP(MPIFMSG)) Q:$E(MPIFMSG,1,3)'="RGA"  D
 .Q:$P(^XTMP(MPIFMSG,0),"^",2)>BEFORE
 .Q:'$D(^XTMP(MPIFMSG,"MPI",0))
 .I $G(^XTMP(MPIFMSG,"MPI",0))="A" D
 ..S TAG=$E(MPIFMSG,3,5)
 ..I TAG="A01"!(TAG="A03")!(TAG="A04")!(TAG="A08") S TAG="A31"
 ..D @TAG S RETURN=1
 K MPIFMSG
 M HL=MPIFHL
 Q
 ;
A28 ;
 K ^XTMP(MPIFMSG)
 N NUM
 S NUM=$$A28^MPIFA28(+$P(MPIFMSG,"%",2))
 Q
A31 ;
 K ^XTMP(MPIFMSG)
 N NUM
 S NUM=$$A31^MPIFA31B(+$P(MPIFMSG,"%",2))
 Q
A29 ;
 K ^XTMP(MPIFMSG)
 N ICN,MSGN
 S ICN=$G(^XTMP(MPIFMSG,"MPI",1)),MSGN=$P(ICN,"^",2),ICN=$P(ICN,"^")
 D START^RGHLLOG()
 D EXC^RGHLLOG(208,"Inactivate msg A29 for DFN= "_$P(MPIFMSG,"%",2)_" with ICN= "_ICN_" original HL7 msg id= "_MSGN_" No ACK received back",$P(MPIFMSG,"%",2))
 D STOP^RGHLLOG()
 Q
A24 ;
 K ^XTMP(MPIFMSG)
 N NUM
 S NUM=$$A24^MPIFA24B(+$P(MPIFMSG,"%",2))
 Q
