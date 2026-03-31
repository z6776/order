<template>
  <view class="ShareCanvas">
    <view class="canvas">
      <canvas canvas-id="shareCanvas" />
    </view>
  </view>
</template>
 
<script>
export default {
  name: 'ShareCanvas',
  methods: {
    // 商品分享
    setGoodsShareCanvas(info) {
      console.log('商品分享--info', info);
      return new Promise(async (resolve, reject) => {
        try {
          const ctx = uni.createCanvasContext('shareCanvas', this)
          // 绘制背景图
          ctx.setFillStyle('#FFFFFF')
          ctx.fillRect(0, 0, 211, 170)
 
 //          // 团长头像
 //          ctx.save();
 //          this.setRadius(ctx, 5, 0, 0, 30, 30)
 //          ctx.clip(); // 画了圆 再剪切 原始画布中剪切任意形状和尺寸。一旦剪切了某个区域，则所有之后的绘图都会被限制在被剪切的区域内
 //          try {
 //            const { path } = await this.getImge(info.avatar)
 //            ctx.drawImage(path, 0, 0, 30, 30)
 //          } catch (error) {
 //            console.error(error);
 //          }
 //          ctx.restore();
 
          // 团长昵称
          // ctx.setFontSize(12);
          // ctx.setTextAlign('left')
          // ctx.setFillStyle('#96999B')
          // ctx.fillText(info.nickname.length > 11 ? info.nickname.slice(0, 11) + `${info.pinkId ? '...的团' : '...'}` : info.nickname + '的团', 35, 18)
 
          // 商品1图
          ctx.save();
          this.setRadius(ctx, 3, 0, 35, 211, 211)
          ctx.clip(); // 画了圆 再剪切 原始画布中剪切任意形状和尺寸。一旦剪切了某个区域，则所有之后的绘图都会被限制在被剪切的区域内
          try {
            const { path } = await this.getImge(info.coverimage)
            ctx.drawImage(path, 0, 35, 211, 211)
          } catch (error) {
            console.error(error);
          }
          ctx.restore();
 
          // 绿色背景
          ctx.setFillStyle('#19C161')
          ctx.fillRect(0, 130, 131, 40) // x, y, width, height
 
          ctx.setFontSize(16);
          ctx.setTextAlign('center')
          ctx.setFillStyle('#FF0000')
          ctx.fillText(`¥${info.price}起`, 65, 130 + 18)
 
          ctx.setFontSize(12);
          ctx.setTextAlign('center')
          ctx.setFillStyle('#FFFFFF')
          ctx.fillText(`已售${info.sales}件`, 65, 130 + 34)
 
          // 划线
          // ctx.beginPath()
          // ctx.setLineWidth(1);
          // ctx.setStrokeStyle('#FFFFFF')
          // ctx.moveTo(40, 130 + 30)
          // ctx.lineTo(90, 130 + 30)
          // ctx.stroke()
 
          // 深绿色背景
          ctx.setFillStyle('#19AF5C')
          ctx.fillRect(131, 130, 211 - 131, 40)
		  
		    ctx.setFontSize(16);
		    ctx.setTextAlign('center')
		    ctx.setFillStyle('#FFFFFF')
		    ctx.fillText(`立即购买`, 131 + (211 - 131) / 2, 130 + 26)
 
          // if (info.pinkId) {
          //   // 立即跟团按钮
          //   ctx.setFontSize(16);
          //   ctx.setTextAlign('center')
          //   ctx.setFillStyle('#FFFFFF')
          //   ctx.fillText(`立即跟团`, 131 + (211 - 131) / 2, 130 + 26)
          // } else {
          //   // 已团数量
          //   ctx.setFontSize(12);
          //   ctx.setTextAlign('center')
          //   ctx.setFillStyle('#FFFFFF')
          //   ctx.fillText(`已团 ${this.getSales(info.sales)} 件`, 131 + (211 - 131) / 2, 130 + 25)
          // }
 
          ctx.draw(false, (() => {
            uni.canvasToTempFilePath({
              canvasId: 'shareCanvas',
              success: (res) => {
                return resolve(res.tempFilePath)
              },
              fail: function (error) {
                console.log('fail----fail', error);
                //TODO
                return reject(error)
              }
            }, this)
          }))
        } catch (error) {
          uni.hideLoading()
          console.log('画图失败error', error);
          return reject(error)
        }
      })
    },
    // 团分享
    setGroupShareCanvas(info) {
      console.log('团分享-info', info);
      return new Promise(async (resolve, reject) => {
        try {
          const ctx = uni.createCanvasContext('shareCanvas', this)
          // 绘制背景图
          ctx.setFillStyle('#FFFFFF')
          ctx.fillRect(0, 0, 211, 170)
            // 团长头像
            ctx.save();
            this.setRadius(ctx, 5, 0, 0, 30, 30)
            ctx.clip(); // 画了圆 再剪切 原始画布中剪切任意形状和尺寸。一旦剪切了某个区域，则所有之后的绘图都会被限制在被剪切的区域内
          
 
            // 商品1图
            ctx.save();
            this.setRadius(ctx, 3, 0, 35, 211, 211)
            ctx.clip(); // 画了圆 再剪切 原始画布中剪切任意形状和尺寸。一旦剪切了某个区域，则所有之后的绘图都会被限制在被剪切的区域内
            try {
              const { path } = await this.getImge(info.image)
              ctx.drawImage(path, 0, 35, 211, 211)
            } catch (error) {
              console.error(error);
            }
            ctx.restore();
          
 
          // 绿色背景
          ctx.setFillStyle('#19C161')
          ctx.fillRect(0, 128, 211, 42) // x, y, width, height
 
 //          ctx.setFontSize(16);
 //          ctx.setTextAlign('center')
 //          ctx.setFillStyle('#FFFFFF')
 //          ctx.fillText(`立即跟团`, 211 / 2, 128 + 26)
 
          ctx.draw(false, (() => {
            uni.canvasToTempFilePath({
              canvasId: 'shareCanvas',
              success: (res) => {
                return resolve(res.tempFilePath)
              },
              fail: function (error) {
                console.log('fail----fail', error);
                //TODO
                return reject(error)
              }
            }, this)
          }))
        } catch (error) {
          console.log('画图失败error', error);
          return reject(error)
        }
      })
    },
    /**
     * 设置圆角矩形
     *
     * @param ctx 绘图上下文
     * @param cornerRadius 圆角半径
     * @param width 矩形宽度
     * @param height 矩形高度
     * @param x 矩形左上角的 x 坐标
     * @param y 矩形左上角的 y 坐标
     * @returns 无返回值
     */
    setRadius(ctx, cornerRadius, x, y, width, height) {
      // 开始绘制路径
      ctx.beginPath();
      // 绘制最左侧的圆角
      ctx.arc(x + cornerRadius, y + cornerRadius, cornerRadius, Math.PI, Math.PI * 1.5);
      // 绘制顶部边缘
      ctx.moveTo(x + cornerRadius, y);
      ctx.lineTo(x + width - cornerRadius, y);
      ctx.lineTo(x + width, y + cornerRadius);
      // 绘制最右侧的圆角
      ctx.arc(x + width - cornerRadius, y + cornerRadius, cornerRadius, Math.PI * 1.5, Math.PI * 2);
      // 绘制右侧边缘
      ctx.lineTo(x + width, y + height - cornerRadius);
      ctx.lineTo(x + width - cornerRadius, y + height);
      // 绘制最下侧的圆角
      ctx.arc(x + width - cornerRadius, y + height - cornerRadius, cornerRadius, 0, Math.PI * 0.5);
      // 绘制底部边缘
      ctx.lineTo(x + cornerRadius, y + height);
      ctx.lineTo(x, y + height - cornerRadius);
      // 绘制最左侧的圆角
      ctx.arc(x + cornerRadius, y + height - cornerRadius, cornerRadius, Math.PI * 0.5, Math.PI);
      // 绘制左侧边缘
      ctx.lineTo(x, y + cornerRadius);
      ctx.lineTo(x + cornerRadius, y);
      // 闭合路径
      ctx.closePath();
    },
    // 获取图片地址
    getImge(path) {
      // 利用promise异步转同步，否则可能显示不了～
	  let _t = this;
      return new Promise((resolve, reject) => {
        uni.getImageInfo({
          src:_t.$util.getImgurl(path),
          success: function (res) {
            if (res && res.path) {
              resolve(res)
            } else {
              reject(false)
            }
          },
          fail: function (res) {
            reject(res)
          }
        })
      })
    },
    getSales(sales) {
      return sales >= 10000 ? sales / 10000 + 'w+' : sales
    },
  }
}
</script>
 
<style lang="scss" scoped>
// 隐藏画布
.ShareCanvas {
  position: absolute;
  top: -200px;
  z-index: -1;
  opacity: 0;
  .canvas canvas {
    width: 211px;
    height: 170px; // +16
  }
}
</style>