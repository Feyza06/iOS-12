# MessageControllerControllerAPI

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**messageControllerControllerCount**](MessageControllerControllerAPI.md#messagecontrollercontrollercount) | **GET** /messages/count | 
[**messageControllerControllerCreate**](MessageControllerControllerAPI.md#messagecontrollercontrollercreate) | **POST** /messages | 
[**messageControllerControllerDeleteById**](MessageControllerControllerAPI.md#messagecontrollercontrollerdeletebyid) | **DELETE** /messages/{id} | 
[**messageControllerControllerFind**](MessageControllerControllerAPI.md#messagecontrollercontrollerfind) | **GET** /messages | 
[**messageControllerControllerFindById**](MessageControllerControllerAPI.md#messagecontrollercontrollerfindbyid) | **GET** /messages/{id} | 
[**messageControllerControllerReplaceById**](MessageControllerControllerAPI.md#messagecontrollercontrollerreplacebyid) | **PUT** /messages/{id} | 
[**messageControllerControllerUpdateAll**](MessageControllerControllerAPI.md#messagecontrollercontrollerupdateall) | **PATCH** /messages | 
[**messageControllerControllerUpdateById**](MessageControllerControllerAPI.md#messagecontrollercontrollerupdatebyid) | **PATCH** /messages/{id} | 


# **messageControllerControllerCount**
```swift
    open class func messageControllerControllerCount(_where: [String: AnyCodable]? = nil, completion: @escaping (_ data: LoopbackCount?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let _where = "TODO" // [String: AnyCodable] |  (optional)

MessageControllerControllerAPI.messageControllerControllerCount(_where: _where) { (response, error) in
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

# **messageControllerControllerCreate**
```swift
    open class func messageControllerControllerCreate(newMessage: NewMessage? = nil, completion: @escaping (_ data: Message?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let newMessage = NewMessage(senderId: "senderId_example", recipientId: "recipientId_example", postId: "postId_example", content: "content_example", createdAt: Date()) // NewMessage |  (optional)

MessageControllerControllerAPI.messageControllerControllerCreate(newMessage: newMessage) { (response, error) in
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
 **newMessage** | [**NewMessage**](NewMessage.md) |  | [optional] 

### Return type

[**Message**](Message.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **messageControllerControllerDeleteById**
```swift
    open class func messageControllerControllerDeleteById(id: Double, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 

MessageControllerControllerAPI.messageControllerControllerDeleteById(id: id) { (response, error) in
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

# **messageControllerControllerFind**
```swift
    open class func messageControllerControllerFind(filter: MessageFilter1? = nil, completion: @escaping (_ data: [MessageWithRelations]?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let filter = Message.Filter1(offset: 123, limit: 123, skip: 123, order: Like_Filter_order(), _where: "TODO", fields: Message_Fields(id: false, senderId: false, recipientId: false, postId: false, content: false, createdAt: false)) // MessageFilter1 |  (optional)

MessageControllerControllerAPI.messageControllerControllerFind(filter: filter) { (response, error) in
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
 **filter** | [**MessageFilter1**](.md) |  | [optional] 

### Return type

[**[MessageWithRelations]**](MessageWithRelations.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **messageControllerControllerFindById**
```swift
    open class func messageControllerControllerFindById(id: Double, filter: MessageFilter? = nil, completion: @escaping (_ data: MessageWithRelations?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let filter = Message.Filter(offset: 123, limit: 123, skip: 123, order: Like_Filter_order(), fields: Message_Fields(id: false, senderId: false, recipientId: false, postId: false, content: false, createdAt: false)) // MessageFilter |  (optional)

MessageControllerControllerAPI.messageControllerControllerFindById(id: id, filter: filter) { (response, error) in
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
 **filter** | [**MessageFilter**](.md) |  | [optional] 

### Return type

[**MessageWithRelations**](MessageWithRelations.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **messageControllerControllerReplaceById**
```swift
    open class func messageControllerControllerReplaceById(id: Double, message: Message? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let message = Message(id: 123, senderId: "senderId_example", recipientId: "recipientId_example", postId: "postId_example", content: "content_example", createdAt: Date()) // Message |  (optional)

MessageControllerControllerAPI.messageControllerControllerReplaceById(id: id, message: message) { (response, error) in
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
 **message** | [**Message**](Message.md) |  | [optional] 

### Return type

**AnyCodable**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **messageControllerControllerUpdateAll**
```swift
    open class func messageControllerControllerUpdateAll(_where: [String: AnyCodable]? = nil, messagePartial: MessagePartial? = nil, completion: @escaping (_ data: LoopbackCount?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let _where = "TODO" // [String: AnyCodable] |  (optional)
let messagePartial = MessagePartial(id: 123, senderId: "senderId_example", recipientId: "recipientId_example", postId: "postId_example", content: "content_example", createdAt: Date()) // MessagePartial |  (optional)

MessageControllerControllerAPI.messageControllerControllerUpdateAll(_where: _where, messagePartial: messagePartial) { (response, error) in
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
 **messagePartial** | [**MessagePartial**](MessagePartial.md) |  | [optional] 

### Return type

[**LoopbackCount**](LoopbackCount.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **messageControllerControllerUpdateById**
```swift
    open class func messageControllerControllerUpdateById(id: Double, messagePartial: MessagePartial? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let messagePartial = MessagePartial(id: 123, senderId: "senderId_example", recipientId: "recipientId_example", postId: "postId_example", content: "content_example", createdAt: Date()) // MessagePartial |  (optional)

MessageControllerControllerAPI.messageControllerControllerUpdateById(id: id, messagePartial: messagePartial) { (response, error) in
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
 **messagePartial** | [**MessagePartial**](MessagePartial.md) |  | [optional] 

### Return type

**AnyCodable**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

