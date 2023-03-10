PSIVINDL ;SLC/SS - PROCESS IV ACTIVITY LOG ENTRIES FOR INDICATION ; Feb 02, 2022
 ;;5.0;INPATIENT MEDICATIONS;**399**;16 DEC 97;Build 64
 ;
 ;
 ;For IV orders only:
 ;Copy activity log entries for INDICATION (only) changes 
 ;from NON-VERIFIED in the file (#53.1) 
 ;to ACTIVE orders in the the file (#55)
 ;during verification process 
CPINDLOG(PSDFN,PS531,PS55100,PSJREAS) ;
 ;PSDFN - patient's DFN
 ;PS531 - IEN of the file (#53.1) 
 ;PS55100 - IEN of IV multiple field (#100) in the file (#55) 
 ;PSJREAS - reason (optional)
 N Z1,Z2,IEN,IEN2,NEWVAL,PSJTMP,NAME,REASON
 S PS531=+PS531,PS55100=+PS55100
 ;get the current value of INDICATION and use as the latest "TO" value 
 S NEWVAL=$G(^PS(53.1,PS531,18))
 ;loop thru all INDICATION log entries in the file (#53.1) from newest to oldest and store all "TO" and "FROM" values in PSJTMP
 S IEN=99999 F  S IEN=$O(^PS(53.1,PS531,"A",IEN),-1) Q:+IEN=0  S Z1=$G(^PS(53.1,PS531,"A",IEN,0)) I $P(Z1,U,4)="INDICATION" D
 . S NAME=$$GET1^DIQ(200,+$P(Z1,U,2),.01,"E")
 . S REASON=$S('$G(PSJREAS):$$GET1^DIQ(53.3,+$P(Z1,U,3),.01,"E"),1:PSJREAS)
 . S PSJTMP(IEN)=PSDFN_U_PS55100_U_"E"_U_NAME_U_REASON_U_+$P(Z1,U)_U_"INDICATION"_U_$P(Z1,U,5)_U_NEWVAL_U_+$P(Z1,U,2)
 . S NEWVAL=$P(Z1,U,5)
 S IEN2=0
 F  S IEN2=$O(PSJTMP(IEN2)) Q:+IEN2=0  S Z2=PSJTMP(IEN2) D ADDENTRY($P(Z2,U,1),$P(Z2,U,2),$P(Z2,U,3),$P(Z2,U,4),$P(Z2,U,5),$P(Z2,U,6),$P(Z2,U,7),$P(Z2,U,8),$P(Z2,U,9),$P(Z2,U,10))
 Q
 ;
 ;Add one single entry to the subfile (#55.04) and its subentry in (#55.15)
ADDENTRY(PSDFN,PS55100,PSACTTYP,PSUSERNM,PSACTRES,PSACTDAT,PSFIELD,PSFROM,PSTO,PSDUZ) ;
 ;PSDFN - patient's DFN
 ;PS55100 - IEN of IV multiple field (#100) in the file (#55) 
 ;PSACTTYP - activity type, see 55.04,.02 
 ;PSUSERNM - User name  (55.04,.03)
 ;PSACTRES  - REASON FOR ACTIVITY (55.04,.04)
 ;PSACTDAT - ACTIVITY DATE (55.04,.05)
 ;PSDUZ - user DUZ (55.04,.06)
 ;PSFIELD - the field that was edited/changed 
 ;PSFROM - old value
 ;PSTO - new value
 S PS55100=+PS55100
 N PS0NODE,PSMAXN,NEWIEN,PSJTMP,NEWIEN2
 ;get the max number used by 55.04,.01 ACTIVITY LOG
 S PSMAXN=$$GETMAXN(PSDFN,PS55100)
 ;in the subfile 55.01,40 ACTIVITY LOG of the file (#55)
 ;create an 55.04 entry with PSMAXN+1 as ACTIVITY LOG value and populate fields: (#.02) TYPE OF ACTIVITY, (#.03) ENTRY CODE, 
 ;(#.04) REASON FOR ACTIVITY, (#.05) ACTIVITY DATE, (#.06) USER 
 S NEWIEN=$$ADD5504(PS55100,PSDFN,PSMAXN+1,PSACTTYP,PSUSERNM,PSACTRES,PSACTDAT,PSDUZ)
 ;in the subfile 55.04,1 FIELD CHANGED of the file (#55)
 ;create an entry and populate fields: (#.01) FIELD CHANGED,(#1) FROM,(#2) TO
 I $$ADD5515(NEWIEN,PS55100,PSDFN,PSFIELD,PSFROM,PSTO)
 Q
 ;
 ;in the subfile 55.04,1  FIELD CHANGED of the file (#55)
 ;create an entry with PSFLCHNG as (#.01) value and populate fields: (#.01) FIELD CHANGED,(#1) FROM,(#2) TO
ADD5504(PS55100,PSDFN,PSMAXN,PSACTTYP,PSUSERNM,PSACTRES,PSACTDAT,PSDUZ) ;
 N PSJTMP,NEWIEN,IENS
 S NEWIEN=$$INSITEM(55.04,PS55100_","_PSDFN,PSMAXN,"")
 ;populate other fiedls
 S IENS=""_NEWIEN_","_PS55100_","_PSDFN_","_""
 S PSJTMP(55.04,IENS,.02)=PSACTTYP
 S PSJTMP(55.04,IENS,.03)=PSUSERNM
 S PSJTMP(55.04,IENS,.04)=PSACTRES
 S PSJTMP(55.04,IENS,.05)=PSACTDAT
 S PSJTMP(55.04,IENS,.06)=PSDUZ
 D FILE^DIE("","PSJTMP")
 Q NEWIEN
 ;
 ;in the subfile 55.04,1  FIELD CHANGED of the file (#55)
 ;create an entry with PSFLCHNG as (#.01) value and populate fields: (#.01) FIELD CHANGED,(#1) FROM,(#2) TO
ADD5515(IEN5515,PS55100,PSDFN,PSFLCHNG,PSFROM,PSTO) ;
 N NEWIEN,PSJTMP,IENS
 S NEWIEN=$$INSITEM(55.15,IEN5515_","_PS55100_","_PSDFN,PSFLCHNG,"")
 ;populate other fiedls
 S IENS=""_NEWIEN_","_IEN5515_","_PS55100_","_PSDFN_","_""
 S PSJTMP(55.15,IENS,1)=PSFROM
 S PSJTMP(55.15,IENS,2)=PSTO
 D FILE^DIE("","PSJTMP")
 Q NEWIEN
 ;
 ; get max number for 55.04,.01 
GETMAXN(DFN,IEN100) ;
 N Z1,NUM,IEN55151 S NUM=0,IEN55151=0
 F  S IEN55151=$O(^PS(55,DFN,"IV",IEN100,"A",IEN55151)) Q:+IEN55151=0  S Z1=+^PS(55,DFN,"IV",IEN100,"A",IEN55151,0) I Z1>NUM S NUM=Z1
 Q NUM
 ;
 ;generic API to insert an entry to the file or subfile
INSITEM(PSFILE,PSIEN,PSVAL01,NEWRECNO,PSFLGS,LCKGL,LCKTIME,PSNEWREC) ;
 ;PSFILE - file or subfile number
 ;PSIEN - ien of the parent file entry in which the new subfile entry will be inserted
 ; = "" - if insert to the top-level
 ; = IEN0 - when you insert to the "child" level - i.e. 1st level after top-level
 ;        IEN0 is the top-leveltop-level IEN
 ; = "IEN1,IEN0" - when you insert to the "grandchild" level - i.e. 2nd level after top-level
 ;        IEN0 is the top-leveltop-level IEN
 ;        IEN1 is the 1st level IEN
 ; = "IEN2,IEN1,IEN0" - when you insert to the 3rd level after top-level
 ;        IEN0 is the top-leveltop-level IEN
 ;        IEN1 is the 1st level IEN
 ;        IEN2 is the 2nd level IEN
 ;PSVAL01 - .01 value for the new entry
 ;NEWRECNO -(optional) specify IEN if you want specific value
 ; Note: "" then the system will assign the entry number itself.
 ;PSFLGS - FLAGS parameter for UPDATE^DIE
 ;LCKGL - fully specified global reference to lock
 ;LCKTIME - time out for LOCK, if LOCKTIME=0 then the function will not lock the file 
 ;PSNEWREC - optional, flag = if 1 then allow to create a new top level record  
 ;
 ;returns IEN of the new entry
 ;Examples: 
 ; W $$INSITEM(55.04,PS55100_","_PSDFN,PSMAXN,"") - 2nd level
 ; W $$INSITEM(55.15,IEN5515_","_PS55100_","_PSDFN,PSFLCHNG,"") - 3rd level
 I ('$G(PSFILE)) Q "0^Invalid parameter"
 I +$G(PSNEWREC)=0 I $G(NEWRECNO)>0,'$G(PSIEN) Q "0^Invalid parameter"
 I $G(PSVAL01)="" Q "0^Null"
 N PSLOCK S PSLOCK=0
 N PSSSI,PSIENS,PSFDA,PSERR
 I '$G(NEWRECNO) N NEWRECNO S NEWRECNO=$G(NEWRECNO)
 I PSIEN'="" S PSIENS="+1,"_PSIEN_"," I $L(NEWRECNO)>0 S PSSSI(1)=+NEWRECNO
 I PSIEN="" S PSIENS="+1," I $L(NEWRECNO)>0 S PSSSI(1)=+NEWRECNO
 S PSFDA(PSFILE,PSIENS,.01)=PSVAL01
 I $L($G(LCKGL)) L +@LCKGL:(+$G(LCKTIME)) S PSLOCK=$T I 'PSLOCK Q -2  ;lock failure
 D UPDATE^DIE($G(PSFLGS),"PSFDA","PSSSI","PSERR")
 I PSLOCK L -@LCKGL
 I $D(PSERR) D BMES^XPDUTL($G(PSERR("DIERR",1,"TEXT",1),"Update Error")) Q -1  ;D BMES^XPDUTL(PSERR("DIERR",1,"TEXT",1))
 Q +$G(PSSSI(1))
 ;
 ;PSIVINDL
