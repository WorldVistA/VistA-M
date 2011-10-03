RTB1 ;MJK/TROY ISC;Help Text for Variable Pointer Fields; ; 1/30/87  10:26 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
HELP F I=1:1 S Y=$P($T(@T+I),";;",2) Q:Y="END"  W !?5,Y
 Q
 ;
HELPFF F I=1:1 S Y=$P($T(@T+I),";;",2) Q:Y="END"  S X="" D:IOSL<($Y+6) TOP^RTB2 Q:X["^"  W !?5,Y
 Q
 ;
TEXT ;;<general help for choosing an entity>
 ;;
 ;;If you simply enter the name then the system will search
 ;;each of the above files for the name you have entered. If
 ;;a match is found the system will ask you if it is the entry
 ;;that you desire.
 ;;
 ;;However, if you know the file name of the entry you want
 ;;then you can speed up processing by using the following
 ;;syntax to choose the entry:
 ;;      <Prefix>.<entry name>
 ;;                or
 ;;      <Message>.<entry name>
 ;;                or
 ;;      <File Name>.<entry name>
 ;;
 ;;Also, you do NOT need to enter the entire file name or message
 ;;to direct the look up. Using the first few characters will
 ;;be enough information.
 ;;
 ;;For example, if one of the files is the 'PROVIDER' file and it
 ;;has a message of 'DOCTOR' and a prefix of 'D', then you can
 ;;enter any of the following to look up the entry CASEY,BEN:
 ;;        1) CASEY,BEN
 ;;        2) CAS
 ;;        3) PROVIDER.CASEY,BEN
 ;;        4) DOCTOR.CASEY,BEN
 ;;        5) PR.CAS
 ;;        6) DOC.CAS
 ;;        7) D.C
 ;;
 ;;END
 ;
ENTHLP ;;<entity specific help text>
 ;;
 ;;[HELP FOR CHOOSING AN ENTRY IN THE RECORDS FILE]
 ;;
 ;;Choose an existing entry by entering any of the following:
 ;;           1) record number
 ;;           2) wand the barcode label on record
 ;;           3) name of the patient (for patient related applications
 ;;                                   such as, radiology and MAS)
 ;;
 ;;END
 ;
BOR ;;<help text describing how to look-up records by borrower>
 ;;OR list records charged out to a particular borrower by
 ;;entering one of the following:
 ;;           1) B.<borrower name>
 ;;               (examples: B.JONES,JOHN
 ;;                          B.JON       )
 ;;           2) B.<borrower's file>.<borrowers name>
 ;;               (examples: B.PROVIDER.JONES,JOHN
 ;;                          B.PRO.JONE            )
 ;;
 ;;END
 ;
