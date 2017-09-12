XU8P327 ;ISC-SF/GB-DELETE BOGUS PERSON CLASS RECORDS ;09/19/2003  13:12
 ;;8.0;KERNEL;**327**;Jul 10, 1995
 Q
POST ; Delete bogus PERSON CLASS records from file 200
 ; ^VA(200,duz,"USC1",-1,0)="^^3030824"
 N I,J
 S I=0
 F  S I=$O(^VA(200,I)) Q:'I  D
 . S J=""
 . F  S J=$O(^VA(200,I,"USC1",J)) Q:J'<0  K ^(J,0)
 Q
