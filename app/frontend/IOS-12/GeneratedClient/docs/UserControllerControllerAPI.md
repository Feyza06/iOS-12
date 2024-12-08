# UserControllerControllerAPI

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**userControllerControllerCount**](UserControllerControllerAPI.md#usercontrollercontrollercount) | **GET** /users/count | 
[**userControllerControllerCreate**](UserControllerControllerAPI.md#usercontrollercontrollercreate) | **POST** /users | 
[**userControllerControllerDeleteById**](UserControllerControllerAPI.md#usercontrollercontrollerdeletebyid) | **DELETE** /users/{id} | 
[**userControllerControllerFind**](UserControllerControllerAPI.md#usercontrollercontrollerfind) | **GET** /users | 
[**userControllerControllerFindById**](UserControllerControllerAPI.md#usercontrollercontrollerfindbyid) | **GET** /users/{id} | 
[**userControllerControllerLogin**](UserControllerControllerAPI.md#usercontrollercontrollerlogin) | **POST** /login | 
[**userControllerControllerReplaceById**](UserControllerControllerAPI.md#usercontrollercontrollerreplacebyid) | **PUT** /users/{id} | 
[**userControllerControllerUpdateAll**](UserControllerControllerAPI.md#usercontrollercontrollerupdateall) | **PATCH** /users | 
[**userControllerControllerUpdateById**](UserControllerControllerAPI.md#usercontrollercontrollerupdatebyid) | **PATCH** /users/{id} | 


# **userControllerControllerCount**
```swift
    open class func userControllerControllerCount(_where: [String: AnyCodable]? = nil, completion: @escaping (_ data: LoopbackCount?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let _where = "TODO" // [String: AnyCodable] |  (optional)

UserControllerControllerAPI.userControllerControllerCount(_where: _where) { (response, error) in
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

# **userControllerControllerCreate**
```swift
    open class func userControllerControllerCreate(newUser: NewUser? = nil, completion: @escaping (_ data: User?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let newUser = NewUser(username: "username_example", email: "email_example", password: "password_example", firstName: "firstName_example", lastName: "lastName_example", photo: "photo_example") // NewUser |  (optional)

UserControllerControllerAPI.userControllerControllerCreate(newUser: newUser) { (response, error) in
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
 **newUser** | [**NewUser**](NewUser.md) |  | [optional] 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userControllerControllerDeleteById**
```swift
    open class func userControllerControllerDeleteById(id: Double, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 

UserControllerControllerAPI.userControllerControllerDeleteById(id: id) { (response, error) in
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

# **userControllerControllerFind**
```swift
    open class func userControllerControllerFind(filter: UserFilter1? = nil, completion: @escaping (_ data: [UserWithRelations]?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let filter = User.Filter1(offset: 123, limit: 123, skip: 123, order: Like_Filter_order(), _where: "TODO", fields: User_Fields(id: false, username: false, email: false, password: false, firstName: false, lastName: false, photo: false), include: [User_IncludeFilter_inner(relation: "relation_example", scope: User.ScopeFilter(offset: 123, limit: 123, skip: 123, order: nil, _where: "TODO", fields: Post_ScopeFilter_fields(), include: ["TODO"]))]) // UserFilter1 |  (optional)

UserControllerControllerAPI.userControllerControllerFind(filter: filter) { (response, error) in
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
 **filter** | [**UserFilter1**](.md) |  | [optional] 

### Return type

[**[UserWithRelations]**](UserWithRelations.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userControllerControllerFindById**
```swift
    open class func userControllerControllerFindById(id: Double, filter: UserFilter? = nil, completion: @escaping (_ data: UserWithRelations?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let filter = User.Filter(offset: 123, limit: 123, skip: 123, order: Like_Filter_order(), fields: User_Fields(id: false, username: false, email: false, password: false, firstName: false, lastName: false, photo: false), include: [User_IncludeFilter_inner(relation: "relation_example", scope: User.ScopeFilter(offset: 123, limit: 123, skip: 123, order: nil, _where: "TODO", fields: Post_ScopeFilter_fields(), include: ["TODO"]))]) // UserFilter |  (optional)

UserControllerControllerAPI.userControllerControllerFindById(id: id, filter: filter) { (response, error) in
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
 **filter** | [**UserFilter**](.md) |  | [optional] 

### Return type

[**UserWithRelations**](UserWithRelations.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userControllerControllerLogin**
```swift
    open class func userControllerControllerLogin(userControllerControllerLoginRequest: UserControllerControllerLoginRequest? = nil, completion: @escaping (_ data: User?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let userControllerControllerLoginRequest = UserControllerController_login_request(email: "email_example", password: "password_example") // UserControllerControllerLoginRequest |  (optional)

UserControllerControllerAPI.userControllerControllerLogin(userControllerControllerLoginRequest: userControllerControllerLoginRequest) { (response, error) in
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
 **userControllerControllerLoginRequest** | [**UserControllerControllerLoginRequest**](UserControllerControllerLoginRequest.md) |  | [optional] 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userControllerControllerReplaceById**
```swift
    open class func userControllerControllerReplaceById(id: Double, user: User? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let user = User(id: 123, username: "username_example", email: "email_example", password: "password_example", firstName: "firstName_example", lastName: "lastName_example", photo: "photo_example") // User |  (optional)

UserControllerControllerAPI.userControllerControllerReplaceById(id: id, user: user) { (response, error) in
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
 **user** | [**User**](User.md) |  | [optional] 

### Return type

**AnyCodable**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userControllerControllerUpdateAll**
```swift
    open class func userControllerControllerUpdateAll(_where: [String: AnyCodable]? = nil, userPartial: UserPartial? = nil, completion: @escaping (_ data: LoopbackCount?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let _where = "TODO" // [String: AnyCodable] |  (optional)
let userPartial = UserPartial(id: 123, username: "username_example", email: "email_example", password: "password_example", firstName: "firstName_example", lastName: "lastName_example", photo: "photo_example") // UserPartial |  (optional)

UserControllerControllerAPI.userControllerControllerUpdateAll(_where: _where, userPartial: userPartial) { (response, error) in
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
 **userPartial** | [**UserPartial**](UserPartial.md) |  | [optional] 

### Return type

[**LoopbackCount**](LoopbackCount.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userControllerControllerUpdateById**
```swift
    open class func userControllerControllerUpdateById(id: Double, userPartial: UserPartial? = nil, completion: @escaping (_ data: AnyCodable?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let id = 987 // Double | 
let userPartial = UserPartial(id: 123, username: "username_example", email: "email_example", password: "password_example", firstName: "firstName_example", lastName: "lastName_example", photo: "photo_example") // UserPartial |  (optional)

UserControllerControllerAPI.userControllerControllerUpdateById(id: id, userPartial: userPartial) { (response, error) in
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
 **userPartial** | [**UserPartial**](UserPartial.md) |  | [optional] 

### Return type

**AnyCodable**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

