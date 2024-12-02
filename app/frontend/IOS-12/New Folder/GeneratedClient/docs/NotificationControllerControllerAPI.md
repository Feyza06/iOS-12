# NotificationControllerControllerAPI

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**notificationControllerControllerCount**](NotificationControllerControllerAPI.md#notificationcontrollercontrollercount) | **GET** /notifications/count | 
[**notificationControllerControllerCreate**](NotificationControllerControllerAPI.md#notificationcontrollercontrollercreate) | **POST** /notifications | 
[**notificationControllerControllerDeleteById**](NotificationControllerControllerAPI.md#notificationcontrollercontrollerdeletebyid) | **DELETE** /notifications/{id} | 
[**notificationControllerControllerFind**](NotificationControllerControllerAPI.md#notificationcontrollercontrollerfind) | **GET** /notifications | 
[**notificationControllerControllerFindById**](NotificationControllerControllerAPI.md#notificationcontrollercontrollerfindbyid) | **GET** /notifications/{id} | 
[**notificationControllerControllerReplaceById**](NotificationControllerControllerAPI.md#notificationcontrollercontrollerreplacebyid) | **PUT** /notifications/{id} | 
[**notificationControllerControllerUpdateAll**](NotificationControllerControllerAPI.md#notificationcontrollercontrollerupdateall) | **PATCH** /notifications | 
[**notificationControllerControllerUpdateById**](NotificationControllerControllerAPI.md#notificationcontrollercontrollerupdatebyid) | **PATCH** /notifications/{id} | 


# **notificationControllerControllerCount**
```swift
    open class func notificationControllerControllerCount(_where: [String: AnyCodable]? = nil, completion: @escaping (_ data: LoopbackCount?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let _where = "TODO" // [String: AnyCodable] |  (optional)

NotificationControllerControllerAPI.notificationControllerControllerCount(_where: _where) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_where** | [**[String: AnyCodable]**](AnyCodable.md) |  | [optional] 

### Return type

[**LoopbackCount**](LoopbackCount.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationControllerControllerCreate**
```swift
    open class func notificationControllerControllerCreate(newNotification: NewNotification? = nil, completion: @escaping (_ data: Notification?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let newNotification = NewNotification(recipientId: "recipientId_example", senderId: "senderId_example", postId: "postId_example", type: "type_example", isRead: false, createdAt: Date()) // NewNotification |  (optional)

NotificationControllerControllerAPI.notificationControllerControllerCreate(newNotification: newNotification) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **newNotification** | [**NewNotification**](NewNotification.md) |  | [optional] 

### Return type

[**Notification**](Notification.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationControllerControllerDeleteById**
```swift
    open class func notificationControllerControllerDeleteById(id: Double, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 

NotificationControllerControllerAPI.notificationControllerControllerDeleteById(id: id) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Double** |  | 

### Return type

**AnyCodable**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationControllerControllerFind**
```swift
    open class func notificationControllerControllerFind(filter: NotificationFilter1? = nil, completion: @escaping (_ data: [NotificationWithRelations]?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let filter = Notification.Filter1(offset: 123, limit: 123, skip: 123, order: Like_Filter_order(), _where: "TODO", fields: Notification_Fields(id: false, recipientId: false, senderId: false, postId: false, type: false, isRead: false, createdAt: false)) // NotificationFilter1 |  (optional)

NotificationControllerControllerAPI.notificationControllerControllerFind(filter: filter) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **filter** | [**NotificationFilter1**](.md) |  | [optional] 

### Return type

[**[NotificationWithRelations]**](NotificationWithRelations.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationControllerControllerFindById**
```swift
    open class func notificationControllerControllerFindById(id: Double, filter: NotificationFilter? = nil, completion: @escaping (_ data: NotificationWithRelations?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let filter = Notification.Filter(offset: 123, limit: 123, skip: 123, order: Like_Filter_order(), fields: Notification_Fields(id: false, recipientId: false, senderId: false, postId: false, type: false, isRead: false, createdAt: false)) // NotificationFilter |  (optional)

NotificationControllerControllerAPI.notificationControllerControllerFindById(id: id, filter: filter) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Double** |  | 
 **filter** | [**NotificationFilter**](.md) |  | [optional] 

### Return type

[**NotificationWithRelations**](NotificationWithRelations.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationControllerControllerReplaceById**
```swift
    open class func notificationControllerControllerReplaceById(id: Double, notification: Notification? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let notification = Notification(id: 123, recipientId: "recipientId_example", senderId: "senderId_example", postId: "postId_example", type: "type_example", isRead: false, createdAt: Date()) // Notification |  (optional)

NotificationControllerControllerAPI.notificationControllerControllerReplaceById(id: id, notification: notification) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Double** |  | 
 **notification** | [**Notification**](Notification.md) |  | [optional] 

### Return type

**AnyCodable**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationControllerControllerUpdateAll**
```swift
    open class func notificationControllerControllerUpdateAll(_where: [String: AnyCodable]? = nil, notificationPartial: NotificationPartial? = nil, completion: @escaping (_ data: LoopbackCount?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let _where = "TODO" // [String: AnyCodable] |  (optional)
let notificationPartial = NotificationPartial(id: 123, recipientId: "recipientId_example", senderId: "senderId_example", postId: "postId_example", type: "type_example", isRead: false, createdAt: Date()) // NotificationPartial |  (optional)

NotificationControllerControllerAPI.notificationControllerControllerUpdateAll(_where: _where, notificationPartial: notificationPartial) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_where** | [**[String: AnyCodable]**](AnyCodable.md) |  | [optional] 
 **notificationPartial** | [**NotificationPartial**](NotificationPartial.md) |  | [optional] 

### Return type

[**LoopbackCount**](LoopbackCount.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **notificationControllerControllerUpdateById**
```swift
    open class func notificationControllerControllerUpdateById(id: Double, notificationPartial: NotificationPartial? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let notificationPartial = NotificationPartial(id: 123, recipientId: "recipientId_example", senderId: "senderId_example", postId: "postId_example", type: "type_example", isRead: false, createdAt: Date()) // NotificationPartial |  (optional)

NotificationControllerControllerAPI.notificationControllerControllerUpdateById(id: id, notificationPartial: notificationPartial) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Double** |  | 
 **notificationPartial** | [**NotificationPartial**](NotificationPartial.md) |  | [optional] 

### Return type

**AnyCodable**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

