#! /bin/sh

# đường dẫn đến project
path=/Users/lifetime/Calendar/Calendar

#link ssh key dẫn đến project 
linkSSh=git@github.com:VNiOS/Calendar.git

#tên project 
myAppName=Calendar

#trỏ đến project
cd $path

#gán ngày tháng hiện tại vào biến Now
Now=$(date +"%Y%m%d")

#cấu hình ssh client sử dụng username và email
git config --global user.name “longpd90”
git config --global user.email “longpd90@gmail.com”


#Hàm pull code về từ sever
PullCodeFromSever()
{
    # add remote ( kiểm tra xem kết nối tới sever được k)
    git remote add origin $linkSSh

    git remote set-url origin $linkSSh
    ##câu lệnh để pull code từ sever về local
    git pull $linkSSh
}
PullCodeFromSever

CreatFolder()
{
#Tạo thư mục có tên là ngày tháng hiện tại
mkdir Release/$Now
}
CreatFolder

#Buil project vừa pull về thành file .ipa
BuildCodeToipa()
{

    #build code to file .app
    xcodebuild -target $myAppName 
    #-sdk "$iphoneos" -configuration Release

       #buld code từ .app thành .ipa từ thưa mục chưa file .app đến thư mục now vừa tạo
    /usr/bin/xcrun -sdk iphoneos PackageApplication -v $path/build/Release-iphoneos/$myAppName.app -o $path/Release/$Now/$myAppName.ipa
    
}

BuildCodeToipa

CommitCodeToSever()
{
    #add tất cả sự thay đổi của project
    git add -A

    #commit lên sever ao
    git commit -a -m" pull code from sever and creat file .ipa and push to sever"

    #Push lên sever github 
    git push $LinkSSh
}

CommitCodeToSever

