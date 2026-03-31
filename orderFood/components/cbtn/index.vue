<template>
	<view class="content">
          <button :open-type="opentype">
			  <slot />
		  </button>
	</view>
</template>

<script>
	export default {
        props:{
			opentype:{
				type:String,
				default:"share"
			},
           width:{
             type:String,
             default:""
           }
        },
        components:{

        },
		data(){
            return{

            }
        },
        methods:{

        }
	}
</script>

<style scoped lang="scss">
button{
	height: auto !important;
	margin: 0 !important;
	padding: 0 !important;
	line-height: initial !important;
	overflow: initial !important;
	background-color: transparent !important;
}
</style>