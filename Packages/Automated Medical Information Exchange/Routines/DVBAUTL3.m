DVBAUTL3 ;ALB/JLU-A general utility routine ;1/28/93
 ;;2.7;AMIE;;Apr 10, 1995
 ;
DEL(DA) ;this subroutine will delete an entry from file 396
 N Z
 S DIK="^DVB(396,"
 D ^DIK
 I IOST?1"C-".E W *7,!,?10,"7131 entry deleted.",?39,"<Return to continue>"
 R Z:DTIME
 K DIK
 Q
 ;
FILE ;this subroutine files the results into 396 for DVBARQP
 N A
 S A=^DVB(396,DVBAENTR,0)
 S $P(A,U,5)=$P(DVBARPT(1),U,2)
 S $P(A,U,9)=$P(DVBARPT(1),U,3)
 S $P(A,U,6)=$P(DVBARPT(2),U,2)
 S $P(A,U,11)=$P(DVBARPT(2),U,3)
 S $P(A,U,7)=$P(DVBARPT(3),U,2)
 S $P(A,U,13)=$P(DVBARPT(3),U,3)
 S $P(A,U,8)=$P(DVBARPT(4),U,2)
 S $P(A,U,15)=$P(DVBARPT(4),U,3)
 S $P(A,U,16)=$P(DVBARPT(5),U,2)
 S $P(A,U,17)=$P(DVBARPT(5),U,3)
 S $P(A,U,18)=$P(DVBARPT(6),U,2)
 S $P(A,U,19)=$P(DVBARPT(6),U,3)
 S $P(A,U,20)=$P(DVBARPT(7),U,2)
 S $P(A,U,21)=$P(DVBARPT(7),U,3)
 S $P(A,U,22)=$P(DVBARPT(8),U,2)
 S $P(A,U,23)=$P(DVBARPT(8),U,3)
 S $P(A,U,24)=$P(DVBARPT(9),U,2)
 S $P(A,U,27)=$P(DVBARPT(10),U,2)
 S $P(A,U,28)=$P(DVBARPT(10),U,3)
 S ^DVB(396,DVBAENTR,0)=A
 S $P(^DVB(396,DVBAENTR,1),U,7)=$P(DVBARPT(9),U,3)
 D DIVUPDT^DVBAUTL2
 Q
 ;
INITRPT ;This subroutine will setup the report array.
 S DVBAO=^DVB(396,DVBAENTR,0)
 S DVBARPT(1)="Notice of discharge"_"^"_$S($D(DVBAEDT):$P(DVBAO,U,5),1:"NO")_"^"_$S($D(DVBAEDT):$P(DVBAO,U,9),1:"")
 S DVBARPT(2)="Hospital Summary"_"^"_$S($D(DVBAEDT):$P(DVBAO,U,6),1:"NO")_"^"_$S($D(DVBAEDT):$P(DVBAO,U,11),1:"")
 S DVBARPT(3)="Certificate (21-day)"_"^"_$S($D(DVBAEDT):$P(DVBAO,U,7),1:"NO")_"^"_$S($D(DVBAEDT):$P(DVBAO,U,13),1:"")
 S DVBARPT(4)="Other/Exam (Review Remarks)"_"^"_$S($D(DVBAEDT):$P(DVBAO,U,8),1:"NO")_"^"_$S($D(DVBAEDT):$P(DVBAO,U,15),1:"")
 S DVBARPT(5)="Special Report"_"^"_$S($D(DVBAEDT):$P(DVBAO,U,16),1:"NO")_"^"_$S($D(DVBAEDT):$P(DVBAO,U,17),1:"")
 S DVBARPT(6)="Competency Report"_"^"_$S($D(DVBAEDT):$P(DVBAO,U,18),1:"NO")_"^"_$S($D(DVBAEDT):$P(DVBAO,U,19),1:"")
 S DVBARPT(7)="VA Form 21-2680"_"^"_$S($D(DVBAEDT):$P(DVBAO,U,20),1:"NO")_"^"_$S($D(DVBAEDT):$P(DVBAO,U,21),1:"")
 S DVBARPT(8)="Asset Information"_"^"_$S($D(DVBAEDT):$P(DVBAO,U,22),1:"NO")_"^"_$S($D(DVBAEDT):$P(DVBAO,U,23),1:"")
 S DVBAP=^DVB(396,DVBAENTR,1)
 S DVBARPT(9)="Admission Report"_"^"_$S($D(DVBAEDT):$P(DVBAO,U,24),1:"NO")_"^"_$S($D(DVBAEDT):$P(DVBAP,U,7),1:"")
 S DVBARPT(10)="Beginning Date Care"_"^"_$S($D(DVBAEDT):$P(DVBAO,U,27),1:"NO")_"^"_$S($D(DVBAEDT):$P(DVBAO,U,28),1:"")
 Q
 ;
IFNPAR() ;
 ;This function call returns the internal entry number of the entry in
 ;the parameter file 396.1.  There are no inputs.  The outputs are either
 ;the IFN or zero.
 ;
 N X
 S X=$O(^DVB(396.1,0))
 I 'X Q 0
 Q X
