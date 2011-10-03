WVRPCNO ;HIOFO/FT-WV NOTIFICATIONS file (790.4) RPCs ;1/7/05  15:03
 ;;1.0;WOMEN'S HEALTH;**16**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ; #10035 - FILE 2          (supported)
 ;
 ; This routine supports the following IAs:
 ; NEW     - 4104
 ;
ACCESION(WVIEN) ; Returns the external value of FILE 790.4, Field .06  
 ;  Input: record ien
 ; Output: external value of the .01 field
 Q $P($G(^WV(790.1,+WVIEN,0)),U,1)
 ;
OUTCOME(WVIEN) ; Returns the external value of FILE 790.405
 ;  Input: record ien
 ; Output: external value of the .01 field
 Q $P($G(^WV(790.405,+WVIEN,0)),U,1)
 ;
PURPOSE(WVIEN) ; Returns the external value of FILE 790.404
 ;  Input: record ien
 ; Output: external value of the .01 field
 Q $P($G(^WV(790.404,+WVIEN,0)),U,1)
 ;
TYPE(WVIEN) ; Returns the external value of FILE 790.403
 ;  Input: record ien
 ; Output: external value of the .01 field
 Q $P($G(^WV(790.403,+WVIEN,0)),U,1)
 ;
NEW(WVRESULT,WVNOTPUR) ; Update procedure result, create notification,
 ; print notification and update treatment needs.
 ;  Input: WVRESULT(n)=FILE 790.1 IEN^"A", "N" or "U" (WVRESULT array is
 ;                     Optional)
 ;         where A=Abnornal, N=No Evidence of Malignancy and
 ;               U=Unsatisfactory for Dx.
 ;         n is a number greater than zero.
 ;    
 ;         WVNOTPUR(FILE 790.404 IEN,n)=FILE 790.1 IEN^"I", "L" or "P"^
 ;                                      FILE 3.5 NAME^DFN
 ;         where I=In-person, L=letter and P=phone call (i.e., 
 ;         notification type)
 ; Output: None
 ;
 N WVCNT,WVDX,WVNODE,WVPURP,WVTYPE
 I $O(WVRESULT(0)) D
 .S WVCNT=0
 .F  S WVCNT=$O(WVRESULT(WVCNT)) Q:'WVCNT  D
 ..S WVDX=$$GETDXIEN^WVRPCNO1($P(WVRESULT(WVCNT),U,2))
 ..D SETRESLT^WVRPCPR($P(WVRESULT(WVCNT),U,1),WVDX)
 ..Q
 .Q
 Q:'$O(WVNOTPUR(0))
 S WVPURP=0
 F  S WVPURP=$O(WVNOTPUR(WVPURP)) Q:'WVPURP  D
 .S WVCNT=0
 .F  S WVCNT=$O(WVNOTPUR(WVPURP,WVCNT)) Q:'WVCNT  D
 ..S WVNODE=$G(WVNOTPUR(WVPURP,WVCNT))
 ..Q:WVNODE=""
 ..;resolve type code to an IEN
 ..S WVTYPE=$P(WVNODE,U,2)
 ..I $P(WVNODE,U,2)'="CPRS" S WVTYPE=$$GETYPIEN^WVRPCNO1($P(WVNODE,U,2))
 ..;throw away printer value if not a letter
 ..I $P(WVNODE,U,2)'="L" S $P(WVNODE,U,3)=""
 ..D ADD($P(WVNODE,U,1),WVPURP,WVTYPE,$P(WVNODE,U,3),$P(WVNODE,U,4))
 ..Q
 .Q
 Q
ADD(WVIEN,WVPURP,WVTYPE,WVPRINTR,WVDFN) ; Create a new notification entry
 ; in FILE 790.4.
 ;  Input:     WVIEN - FILE 790.1 IEN [Required]
 ;            WVPURP - FILE 790.404 IEN [Required]
 ;            WVTYPE - FILE 790.403 IEN [Required]
 ;          WVPRINTR - FILE 3.5 NAME (device) [Optional]              
 ;             WVDFN - FILE 790 IEN [Optional] 
 ; Output: <None>
 ;
 N BRDD,BRTX,CRDD,CRTX,DA,DFN,DLAYGO
 N WVDA7904,WVDXFLAG,WVERR,WVERRADD,WVFAC,WVFDA,WVFDAIEN
 N WVLDAT,WVLPRG,WVNODE,WVNPFLAG,WVOUTCUM,WVPDATE,WVTXFLAG
 I $G(WVIEN)>0 D
 .S WVNODE=$G(^WV(790.1,+$G(WVIEN),0))
 .Q:WVNODE=""
 .S WVDFN=$P(WVNODE,U,2)
 .S WVFAC=+$P(WVNODE,U,10)
 .S WVPDATE=$P(WVNODE,U,12) ;procedure date
 .Q
 Q:'$G(WVDFN)
 S WVNPFLAG=0 ;new patient flag
 I '$D(^WV(790,+$G(WVDFN),0)) D  Q:'WVNPFLAG  ;patient not in WH package
 .Q:$P($G(^DPT(WVDFN,0)),U,2)'="F"  ;not female
 .Q:'$D(^WV(790.02,DUZ(2)))  ;no site parameters
 .Q:'$P($G(^WV(790.02,+$G(DUZ(2)),0)),U,2)  ;no default case mgr
 .S DFN=WVDFN
 .Q:'$$VNVEC^WVRALIN1()  ;vet/non-vet/eligibility code check
 .S WVERRADD=1
 .D AUTOADD^WVPATE(WVDFN,DUZ(2),.WVERRADD) ;add patient to FILE 790
 .I WVERRADD>0 S WVNPFLAG=1 ;patient added
 .Q
 I '$D(^WV(790.404,+$G(WVPURP),0)) Q  ;purpose
 I '$G(WVFAC) S WVFAC=DUZ(2) ;facility ien
 S WVDXFLAG=$P($G(^WV(790.02,+WVFAC,0)),U,11,12)
 S WVTXFLAG=$P(WVDXFLAG,U,2) ;update treatment needs?
 S WVDXFLAG=$P(WVDXFLAG,U,1) ;update results/dx?
 S:$G(WVPDATE)'>0 WVPDATE=DT ;use today if no procedure date 
 I $G(WVTYPE)="CPRS" G TX
 I '$D(^WV(790.403,+$G(WVTYPE),0)) Q  ;type
 S WVOUTCUM=""
 I $G(WVPRINTR)]"" S WVOUTCUM=$$GETOIEN^WVRPCNO1("Letter Sent")
 ; create File 790.4 entry
 S WVFDA(790.4,"+1,",.01)=WVDFN ;DFN
 S WVFDA(790.4,"+1,",.02)=DT ;date opened
 S WVFDA(790.4,"+1,",.03)=WVTYPE ;type
 S WVFDA(790.4,"+1,",.04)=WVPURP ;purpose
 S WVFDA(790.4,"+1,",.05)=WVOUTCUM ;outcome
 S WVFDA(790.4,"+1,",.06)=$G(WVIEN) ;wh accession #
 S WVFDA(790.4,"+1,",.07)=$S($G(WVFAC):$G(WVFAC),1:DUZ(2)) ;facility
 S WVFDA(790.4,"+1,",.08)=DT ;date closed
 I $P($G(^WV(790.403,+$G(WVTYPE),0)),U,2)=1 D
 .S WVFDA(790.4,"+1,",.11)=DT ;print date
 .Q
 S WVFDA(790.4,"+1,",.13)=DT ;complete by date
 S WVFDA(790.4,"+1,",.14)="c" ;status
 D UPDATE^DIE("","WVFDA","WVFDAIEN","WVERR")
 S WVDA7904=WVFDAIEN(1)
 ;
TX ; update treatment needs
 I WVTXFLAG=1 D
 .S WVNODE=$G(^WV(790.404,WVPURP,0))
 .S BRTX=$S($P(WVNODE,U,7)]"":$P(WVNODE,U,7),1:"") ;breast tx need
 .S BRDD=$S($P(WVNODE,U,8)]"":$P(WVNODE,U,8),1:"") ;breast tx due date
 .S CRTX=$S($P(WVNODE,U,9)]"":$P(WVNODE,U,9),1:"") ;cervical tx need
 .S CRDD=$S($P(WVNODE,U,10)]"":$P(WVNODE,U,10),1:"") ;cervical tx due date
 .D BRTX^WVRPCPT(WVDFN,BRTX,BRDD,CRTX,CRDD,WVPDATE) ;update tx needs & due dates
 .Q
 ; print notification?
 Q:$G(WVPRINTR)=""  ;no printer defined
 Q:$P($G(^WV(790.403,+$G(WVTYPE),0)),U,2)'=1  ;not printable
 S WVPRINTR=$P(WVPRINTR,";",2)
 Q:WVPRINTR=""
 D DEVICE^WVRPCNO1(WVDA7904,WVPRINTR) ;print letter
 Q
