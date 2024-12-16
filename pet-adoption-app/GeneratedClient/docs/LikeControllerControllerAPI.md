# LikeControllerControllerAPI

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**likeControllerControllerCount**](LikeControllerControllerAPI.md#likecontrollercontrollercount) | **GET** /likes/count | 
[**likeControllerControllerCreate**](LikeControllerControllerAPI.md#likecontrollercontrollercreate) | **POST** /likes | 
[**likeControllerControllerDeleteById**](LikeControllerControllerAPI.md#likecontrollercontrollerdeletebyid) | **DELETE** /likes/{id} | 
[**likeControllerControllerFind**](LikeControllerControllerAPI.md#likecontrollercontrollerfind) | **GET** /likes | 
[**likeControllerControllerFindById**](LikeControllerControllerAPI.md#likecontrollercontrollerfindbyid) | **GET** /likes/{id} | 
[**likeControllerControllerReplaceById**](LikeControllerControllerAPI.md#likecontrollercontrollerreplacebyid) | **PUT** /likes/{id} | 
[**likeControllerControllerUpdateAll**](LikeControllerControllerAPI.md#likecontrollercontrollerupdateall) | **PATCH** /likes | 
[**likeControllerControllerUpdateById**](LikeControllerControllerAPI.md#likecontrollercontrollerupdatebyid) | **PATCH** /likes/{id} | 


# **likeControllerControllerCount**
```swift
    open class func likeControllerControllerCount(_where: [String: AnyCodable]? = nil, completion: @escaping (_ data: LoopbackCount?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let _where = "TODO" // [String: AnyCodable] |  (optional)

LikeControllerControllerAPI.likeControllerControllerCount(_where: _where) { (response, error) in
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

# **likeControllerControllerCreate**
```swift
    open class func likeControllerControllerCreate(newLike: NewLike? = nil, completion: @escaping (_ data: Like?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let newLike = NewLike(userId: "userId_example", postId: "postId_example", createdAt: Date()) // NewLike |  (optional)

LikeControllerControllerAPI.likeControllerControllerCreate(newLike: newLike) { (response, error) in
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
 **newLike** | [**NewLike**](NewLike.md) |  | [optional] 

### Return type

[**Like**](Like.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **likeControllerControllerDeleteById**
```swift
    open class func likeControllerControllerDeleteById(id: Double, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 

LikeControllerControllerAPI.likeControllerControllerDeleteById(id: id) { (response, error) in
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

# **likeControllerControllerFind**
```swift
    open class func likeControllerControllerFind(filter: LikeFilter1? = nil, completion: @escaping (_ data: [LikeWithRelations]?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let filter = Like.Filter1(offset: 123, limit: 123, skip: 123, order: Like_Filter_order(), _where: "TODO", fields: Like_Fields(id: false, userId: false, postId: false, createdAt: false)) // LikeFilter1 |  (optional)

LikeControllerControllerAPI.likeControllerControllerFind(filter: filter) { (response, error) in
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
 **filter** | [**LikeFilter1**](.md) |  | [optional] 

### Return type

[**[LikeWithRelations]**](LikeWithRelations.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **likeControllerControllerFindById**
```swift
    open class func likeControllerControllerFindById(id: Double, filter: LikeFilter? = nil, completion: @escaping (_ data: LikeWithRelations?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let filter = Like.Filter(offset: 123, limit: 123, skip: 123, order: Like_Filter_order(), fields: Like_Fields(id: false, userId: false, postId: false, createdAt: false)) // LikeFilter |  (optional)

LikeControllerControllerAPI.likeControllerControllerFindById(id: id, filter: filter) { (response, error) in
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
 **filter** | [**LikeFilter**](.md) |  | [optional] 

### Return type

[**LikeWithRelations**](LikeWithRelations.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **likeControllerControllerReplaceById**
```swift
    open class func likeControllerControllerReplaceById(id: Double, like: Like? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let like = Like(id: 123, userId: "userId_example", postId: "postId_example", createdAt: Date()) // Like |  (optional)

LikeControllerControllerAPI.likeControllerControllerReplaceById(id: id, like: like) { (response, error) in
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
 **like** | [**Like**](Like.md) |  | [optional] 

### Return type

**AnyCodable**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **likeControllerControllerUpdateAll**
```swift
    open class func likeControllerControllerUpdateAll(_where: [String: AnyCodable]? = nil, likePartial: LikePartial? = nil, completion: @escaping (_ data: LoopbackCount?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let _where = "TODO" // [String: AnyCodable] |  (optional)
let likePartial = LikePartial(id: 123, userId: "userId_example", postId: "postId_example", createdAt: Date()) // LikePartial |  (optional)

LikeControllerControllerAPI.likeControllerControllerUpdateAll(_where: _where, likePartial: likePartial) { (response, error) in
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
 **likePartial** | [**LikePartial**](LikePartial.md) |  | [optional] 

### Return type

[**LoopbackCount**](LoopbackCount.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **likeControllerControllerUpdateById**
```swift
    open class func likeControllerControllerUpdateById(id: Double, likePartial: LikePartial? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let likePartial = LikePartial(id: 123, userId: "userId_example", postId: "postId_example", createdAt: Date()) // LikePartial |  (optional)

LikeControllerControllerAPI.likeControllerControllerUpdateById(id: id, likePartial: likePartial) { (response, error) in
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
 **likePartial** | [**LikePartial**](LikePartial.md) |  | [optional] 

### Return type

**AnyCodable**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

