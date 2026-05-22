# 专家画像展示系统 - 部署说明

## 本地使用

双击无法直接打开（浏览器跨域限制），请用以下方式：

```bash
cd web_viewer
python -m http.server 8080
```

然后浏览器访问 http://localhost:8080

## 线上部署

本系统为纯静态站点，只需将 `web_viewer` 文件夹中的两个文件部署到任何Web服务器即可：

- `index.html` - 界面主文件
- `experts_data.json` - 专家数据

### 部署方式（任选其一）

**1. Nginx / Apache**
将两个文件放到网站根目录即可。

**2. GitHub Pages**
创建GitHub仓库，将两个文件推送到 `main` 分支，启用 Pages 即可。

**3. 云服务器（阿里云/腾讯云等）**
将文件上传到 OSS/COS 开启静态网站托管。

**4. Vercel / Netlify**
直接拖拽 `web_viewer` 文件夹到平台即可一键部署。

## 数据更新

当有新专家完成调研后，重新运行数据汇总脚本生成新的 `experts_data.json` 替换即可。

```python
import os, json
base = r'C:\教育部学位中心工作\专家数据库\高水平专家数据库V1'
experts = []
for d in sorted(os.listdir(base)):
    jp = os.path.join(base, d, 'portrait_data.json')
    if os.path.isfile(jp):
        with open(jp, 'r', encoding='utf-8') as f:
            experts.append(json.load(f))
with open(os.path.join(base, 'web_viewer', 'experts_data.json'), 'w', encoding='utf-8') as f:
    json.dump(experts, f, ensure_ascii=False)
```

## 功能特性

- 支持按姓名、单位、职称搜索
- 支持按"已调研/待完善"状态筛选
- 键盘上下箭头快捷导航
- 响应式设计，支持移动端访问
- 六维度评价矩阵可视化展示
