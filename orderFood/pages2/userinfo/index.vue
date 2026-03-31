<template>
    <view class="">
        <view>
            <view class="express">
                <view class="info">
                    <view :class="{hide:!iSinfo}">{{ filterdetail(content)}}</view>
                    <view class="tips" @click="showinfo" v-if="!iSinfo">
                        <u-icon name="arrow-down" :size="24+'rpx'" color="#0078FF" label="展开" labelPos="left" labelColor="#0078FF" :labelSize="28+'rpx'"></u-icon>
                    </view>
                </view>
                <view class="tips hidebtn" @click="showinfo" v-if="iSinfo">
                    <u-icon name="arrow-up" :size="24+'rpx'" color="#0078FF" label="收起" labelPos="left" labelColor="#0078FF" :labelSize="28+'rpx'"></u-icon>
                </view>
            </view>
        </view>
    </view>
</template>
<script>
    export default {
        data() {
            return {
                iSinfo: false,
                content: `享受了工作带来的薪酬与成长，就要接纳工作带来的辛苦与忙碌，每一刻疲劳的瞬间，我想的都是好好赚钱好好生活。`
            }
        },
		computed:{
			hideLen(){
			   return this.content;	
			}
		},
        methods: {
            // 全文展开收起
            showinfo() {
                this.iSinfo = !this.iSinfo
            },
			filterdetail(e){
				if(!this.iSinfo && this.hideLen){
					// 75
					console.log(e.substring(0,e.length-8),"e.substring(0,e.length-5)e.substring(0,e.length-5)");
					return e.substring(0,e.length-8)+"...";
				}
				return e;
			}
        }
    }
</script>

<style lang="scss" scoped>
    // 展开收起
    .express {
        display: flex;
        // width: 100%;
        flex-direction: column;
        background-color: #fff;
        padding: 30rpx;

        position: relative;

        .info {
            display: flex;
            flex-direction: column;

            .tips {
                width: 150rpx;
                height: 40rpx;
                display: flex;
                justify-content: flex-end;
                align-items: center;
                background: linear-gradient(90deg, rgba(255, 255, 255, 0) 0%, rgba(255, 255, 255, 1) 50%);

                position: absolute;
                bottom: 30rpx;
                right: 30rpx;
                font-size: 28rpx !important;
            }
        }

    }

    // 收起 按钮
    .hidebtn {
        display: flex;
        flex: 1;
        justify-content: flex-end;
        color: #0078FF;
        font-size: 28rpx;
    }

    // 展开 文字
    .hide {
        word-break: break-word; //换行模式
        overflow: hidden;
        text-overflow: ellipsis; //修剪文字，超过2行显示省略号
        display: -webkit-box;
        -webkit-line-clamp: 2; //此处为上限行数
        -webkit-box-orient: vertical;
    }
</style>
