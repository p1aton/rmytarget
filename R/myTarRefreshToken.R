myTarRefreshToken <-
function(old_auth = NULL, client_id = NULL,client_secret = NULL){
  if(is.null(old_auth) | is.null(client_id) | is.null(client_secret)){
    #lost_arguments <- paste(ifelse(is.null(old_auth),"old_auth",""),ifelse(is.null(client_id),"client_id",""),ifelse(is.null(client_secret),"client_secret",""),sep = ",")
    stop("��� ��������� ������� �������� ������������, ���������� ��������� �������� ���������� ",call. = FALSE)
  }
  query_body <- paste0("grant_type=", "refresh_token",
                       "&refresh_token=", old_auth$refresh_token,
                       "&client_id=", client_id,
                       "&client_secret=", client_secret)
  
  mtRefrsh <- POST("https://target.my.com/api/v2/oauth2/token.json",body = query_body, content_type(type = "application/x-www-form-urlencoded"))
  stop_for_status(mtRefrsh)
  mtRefrsh <- content(mtRefrsh, "parsed", "application/json")
  #������ ������ ������� �� �����
  old_auth$access_token <- mtRefrsh$access_token
  return(old_auth)
}
