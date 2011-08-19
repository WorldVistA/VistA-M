EEOIPRE ;HISC/JWR-Deletes the old trigger x-ref on field 48 of file 785 ;Apr 20, 1995
 ;;2.0;EEO Complaint Tracking;;Apr 27, 1995
 S DIK="^DD(785,48,1,"
 S DA=1,DA(1)=48,DA(2)=785
 D ^DIK K DIK,DA Q
