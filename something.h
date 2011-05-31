/*
 *  something.h
 *  spotAPI
 *
 *  Created by Ruaridh Thomson on 10/09/2010.
 *  Copyright 2010 Life Up North. All rights reserved.
 *
 */

//
//  stuff.h
//  spotAPI
//
//  Created by Ruaridh Thomson on 10/09/2010.
//  Copyright 2010 Life Up North. All rights reserved.
//

#pragma mark Named Structures

struct AdQueueEntry;

struct AlbumInfo;

struct ArtistInfo;

struct AudioDeviceListenerOSX;

struct FileId {
    unsigned char _field1[20];
};

struct GenericClass;

struct GuiCanvas;

struct GuiControl;

struct GuiEditBoxPriv;

struct GuiManager;

struct GuiSpecRect {
    short left;
    short top;
    short width;
    short height;
    short fill;
};

struct IGenericView;

struct IPopupMenu {
    void **_field1;
};

struct MetadataEditorWindowDelegate {
    void **_field1;
};

struct MetadataParser;

struct OsAlias;

struct PestoView;

struct PestoWindowListener;

struct PurchaseLinks;

/*
struct RefPtr<sp::AlbumInfo> {
    struct AlbumInfo *_field1;
};

struct RefPtr<sp::ArtistInfo> {
    struct ArtistInfo *_field1;
};
 */

struct SkinManager;

struct StrPtrStruct;

struct String {
    union {
        char *t;
        struct StrPtrStruct *_d;
    } ;
};

struct TrackData;

struct TrackId {
    unsigned char _field1[16];
};

struct TrackInfo {
    void **_field1;
    int _field2;
    char *_field3;
    unsigned int _field4;
    //struct RefPtr<sp::AlbumInfo> _field5;
    //struct RefPtr<sp::ArtistInfo> _field6;
    unsigned char _field7;
    unsigned char _field8;
    unsigned char _field9;
    unsigned int :1;
    unsigned int :1;
    unsigned int :1;
    unsigned int :1;
    unsigned int :1;
    unsigned int :3;
    unsigned int :2;
    unsigned int :1;
    unsigned int :1;
    unsigned int :3;
    unsigned int :1;
    unsigned int :2;
    unsigned int :2;
    unsigned int :1;
    unsigned int :1;
    unsigned int :1;
    unsigned int :1;
    unsigned int :1;
    unsigned int :1;
    unsigned int :1;
    unsigned int :1;
    unsigned char _field10;
    struct TrackInfo *_field11;
    //struct VersionAndExpiry _field12;
    int _field13;
    struct TrackRelation *_field14;
    struct TrackInfo *_field15;
    struct TrackInfo *_field16;
    struct ArtistInfo **_field17;
    struct FileId _field18[2];
    union {
        struct TrackId _field1;
        struct {
            struct TrackInfo *_field1;
            unsigned int _field2;
            struct TrackInfo *_field3;
            char *_field4;
        } _field2;
    } _field19;
    union {
        struct PurchaseLinks *_field1;
        char *_field2;
        struct AdQueueEntry *_field3;
    } _field20;
    struct OsAlias *_field21;
};

struct TrackRelation;

struct UserPasswordVerifier {
    void **_field1;
};

struct VersionAndExpiry {
    unsigned int _field1;
    unsigned int _field2;
};

struct WebBrowserNotifications;

struct WindowSettings {
    struct Rect _field1;
    int _field2;
};

struct in_addr {
    unsigned int _field1;
};

struct sockaddr_in {
    unsigned char _field1;
    unsigned char _field2;
    unsigned short _field3;
    struct in_addr _field4;
    char _field5[8];
};