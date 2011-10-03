PRCNHLP ;SSI/SEB-Help/lookup for NX ;[ 02/07/96  1:56 PM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
A ; Executable help for Contract field of vendor file (440)
 NEW I
 S V=$S($D(DG("0;2")):DG("0;2"),1:$P(^PRCN(413,DA(1),1,DA,0),U,2)),I=0
 Q:V=""  W !,"Contracts on file for ",$P(^PRC(440,V,0),U),":"
 F J=1:1 S I=$O(^PRC(440,V,4,I)) W:I>0 ! G:I'>0 EXIT D
 . W:$P(^PRC(440,V,4,I,0),U,2)>DT !,$P(^PRC(440,V,4,I,0),U)
 G EXIT
B ; Input transform for Contract field of vendor file (440)
 NEW I
 S V=$S($D(DG("0;2")):DG("0;2"),1:$P(^PRCN(413,DA(1),1,DA,0),U,2))
 Q:V=""
 S I=$O(^PRC(440,V,"B",4,X,""))
 I I]"" K:$P(^PRC(440,V,4,I,0),U,3)'=V!($P(^PRC(440,V,4,I,0),U,2)'>DT) X
EXIT K I,J,V
 Q
