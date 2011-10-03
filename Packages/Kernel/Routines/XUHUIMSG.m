XUHUIMSG ;SFISC/SO- Create Mail Message Of Change ;6:27 AM  10 Jun 2002
 ;;8.0;KERNEL;**236**;Jul 10, 1995
 I XUHUIXR="AXUHUI" D M200 Q
 D MKEY
 Q
 ;
M200 ; Build message for top level file 200 stuff
 N I,MTEXT,SUBJ
 S I=1,MTEXT=""
 S MTEXT(I)=" ",I=I+1
 S MTEXT(I)="Event Change - Name or Termination Date or DOB or SSN or several of these.",I=I+1
 S MTEXT(I)=" ",I=I+1
 S MTEXT(I)="Orginal Name: "_XUHUIX1,I=I+1
 S MTEXT(I)=" ",I=I+1
 S MTEXT(I)="Old Name: "_XUHUIX1(1)_"  New Name: "_XUHUIX2(1),I=I+1
 S MTEXT(I)="Old Termination Date: "_XUHUIX1(2)_"  New Termination Date: "_XUHUIX2(2),I=I+1
 S MTEXT(I)="Old DOB: "_XUHUIX1(3)_"  New DOB: "_XUHUIX2(3),I=I+1
 S MTEXT(I)="Old SSN: "_XUHUIX1(4)_"  New SSN: "_XUHUIX2(4)
 S SUBJ="Hui Change Event (New Person)"
 D SENDIT
 Q
 ;
MKEY ; Build message for Provider Key change of status
 N MTEXT,I,SUBJ,NAME,SSN
 S I=1,MTEXT=""
 S MTEXT(I)=" ",I=I+1
 D CLEAN^DILF
 S NAME=$$GET1^DIQ(200,XUHUIDA(1)_",","NAME")
 S SSN=$$GET1^DIQ(200,XUHUIDA(1)_",","SSN")
 D CLEAN^DILF
 S MTEXT(I)="Name: "_NAME_"  SSN: "_SSN,I=I+1
 D CLEAN^DILF
 I $P(^DIC(19.1,XUHUIX,0),U)="PROVIDER" S MTEXT(I)="Provider Key: "_$S(XUHUIA="S":"Allocated",1:"De-allocated")
 S SUBJ="Hui Change Event (Provider Key)"
 D SENDIT
 Q
 ;
SENDIT ; Send the message
 ; Test to see if there are MEMBERS to prevent Unreferenced message
 I '$$GOTLOCAL^XMXAPIG("XUHUI CHANGE EVENT") Q  ;Mail Group Has No Members
 ; Mail Group Has Memebers so send the message
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MTEXT","G.XUHUI CHANGE EVENT")
 Q
