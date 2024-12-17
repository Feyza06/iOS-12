# PostControllerControllerAPI

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**postControllerControllerCount**](PostControllerControllerAPI.md#postcontrollercontrollercount) | **GET** /posts/count | 
[**postControllerControllerCreate**](PostControllerControllerAPI.md#postcontrollercontrollercreate) | **POST** /posts | 
[**postControllerControllerDeleteById**](PostControllerControllerAPI.md#postcontrollercontrollerdeletebyid) | **DELETE** /posts/{id} | 
[**postControllerControllerFind**](PostControllerControllerAPI.md#postcontrollercontrollerfind) | **GET** /posts | 
[**postControllerControllerFindById**](PostControllerControllerAPI.md#postcontrollercontrollerfindbyid) | **GET** /posts/{id} | 
[**postControllerControllerReplaceById**](PostControllerControllerAPI.md#postcontrollercontrollerreplacebyid) | **PUT** /posts/{id} | 
[**postControllerControllerUpdateAll**](PostControllerControllerAPI.md#postcontrollercontrollerupdateall) | **PATCH** /posts | 
[**postControllerControllerUpdateById**](PostControllerControllerAPI.md#postcontrollercontrollerupdatebyid) | **PATCH** /posts/{id} | 


# **postControllerControllerCount**
```swift
    open class func postControllerControllerCount(_where: [String: AnyCodable]? = nil, completion: @escaping (_ data: LoopbackCount?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let _where = "TODO" // [String: AnyCodable] |  (optional)

PostControllerControllerAPI.postControllerControllerCount(_where: _where) { (response, error) in
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

# **postControllerControllerCreate**
```swift
    open class func postControllerControllerCreate(newPost: NewPost? = nil, completion: @escaping (_ data: Post?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let newPost = NewPost(petName: "petName_example", petType: "petType_example", petBreed: "petBreed_example", gender: "gender_example", photo: false, description: "description_example", preferredHome: "preferredHome_example", status: "status_example", createdAt: Date(), userId: "userId_example") // NewPost |  (optional)

PostControllerControllerAPI.postControllerControllerCreate(newPost: newPost) { (response, error) in
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
 **newPost** | [**NewPost**](NewPost.md) |  | [optional] 

### Return type

[**Post**](Post.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postControllerControllerDeleteById**
```swift
    open class func postControllerControllerDeleteById(id: Double, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 

PostControllerControllerAPI.postControllerControllerDeleteById(id: id) { (response, error) in
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

# **postControllerControllerFind**
```swift
    open class func postControllerControllerFind(filter: PostFilter1? = nil, completion: @escaping (_ data: [PostWithRelations]?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let filter = Post.Filter1(offset: 123, limit: 123, skip: 123, order: Like_Filter_order(), _where: "TODO", fields: Post_Fields(id: false, petName: false, petType: false, petBreed: false, gender: false, photo: false, description: false, preferredHome: false, status: false, createdAt: false, userId: false), include: [Post_IncludeFilter_inner(relation: "relation_example", scope: Post.ScopeFilter(offset: 123, limit: 123, skip: 123, order: nil, _where: "TODO", fields: Post_ScopeFilter_fields(), include: ["TODO"]))]) // PostFilter1 |  (optional)

PostControllerControllerAPI.postControllerControllerFind(filter: filter) { (response, error) in
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
 **filter** | [**PostFilter1**](.md) |  | [optional] 

### Return type

[**[PostWithRelations]**](PostWithRelations.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postControllerControllerFindById**
```swift
    open class func postControllerControllerFindById(id: Double, filter: PostFilter? = nil, completion: @escaping (_ data: PostWithRelations?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let filter = Post.Filter(offset: 123, limit: 123, skip: 123, order: Like_Filter_order(), fields: Post_Fields(id: false, petName: false, petType: false, petBreed: false, gender: false, photo: false, description: false, preferredHome: false, status: false, createdAt: false, userId: false), include: [Post_IncludeFilter_inner(relation: "relation_example", scope: Post.ScopeFilter(offset: 123, limit: 123, skip: 123, order: nil, _where: "TODO", fields: Post_ScopeFilter_fields(), include: ["TODO"]))]) // PostFilter |  (optional)

PostControllerControllerAPI.postControllerControllerFindById(id: id, filter: filter) { (response, error) in
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
 **filter** | [**PostFilter**](.md) |  | [optional] 

### Return type

[**PostWithRelations**](PostWithRelations.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postControllerControllerReplaceById**
```swift
    open class func postControllerControllerReplaceById(id: Double, post: Post? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let post = Post(id: 123, petName: "petName_example", petType: "petType_example", petBreed: "petBreed_example", gender: "gender_example", photo: false, description: "description_example", preferredHome: "preferredHome_example", status: "status_example", createdAt: Date(), userId: "userId_example") // Post |  (optional)

PostControllerControllerAPI.postControllerControllerReplaceById(id: id, post: post) { (response, error) in
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
 **post** | [**Post**](Post.md) |  | [optional] 

### Return type

**AnyCodable**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postControllerControllerUpdateAll**
```swift
    open class func postControllerControllerUpdateAll(_where: [String: AnyCodable]? = nil, postPartial: PostPartial? = nil, completion: @escaping (_ data: LoopbackCount?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let _where = "TODO" // [String: AnyCodable] |  (optional)
let postPartial = PostPartial(id: 123, petName: "petName_example", petType: "petType_example", petBreed: "petBreed_example", gender: "gender_example", photo: false, description: "description_example", preferredHome: "preferredHome_example", status: "status_example", createdAt: Date(), userId: "userId_example") // PostPartial |  (optional)

PostControllerControllerAPI.postControllerControllerUpdateAll(_where: _where, postPartial: postPartial) { (response, error) in
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
 **postPartial** | [**PostPartial**](PostPartial.md) |  | [optional] 

### Return type

[**LoopbackCount**](LoopbackCount.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postControllerControllerUpdateById**
```swift
    open class func postControllerControllerUpdateById(id: Double, postPartial: PostPartial? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let postPartial = PostPartial(id: 123, petName: "petName_example", petType: "petType_example", petBreed: "petBreed_example", gender: "gender_example", photo: false, description: "description_example", preferredHome: "preferredHome_example", status: "status_example", createdAt: Date(), userId: "userId_example") // PostPartial |  (optional)

PostControllerControllerAPI.postControllerControllerUpdateById(id: id, postPartial: postPartial) { (response, error) in
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
 **postPartial** | [**PostPartial**](PostPartial.md) |  | [optional] 

### Return type

**AnyCodable**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

